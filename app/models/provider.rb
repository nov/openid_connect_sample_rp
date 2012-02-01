class Provider < ActiveRecord::Base
  has_many :open_ids
  belongs_to :account

  validates :issuer,                 presence: true, uniqueness: {allow_nil: true}
  validates :name,                   presence: true
  validates :identifier,             presence: {if: :associated?}
  validates :authorization_endpoint, presence: {if: :associated?}
  validates :token_endpoint,         presence: {if: :associated?}
  validates :check_id_endpoint,      presence: {if: :associated?}
  validates :user_info_endpoint,     presence: {if: :associated?}

  scope :dynamic,  where(dynamic: true)
  scope :listable, where(dynamic: false)
  scope :valid, lambda {
    where {
      (expires_at == nil) |
      (expires_at >= Time.now.utc)
    }
  }

  def expired?
    expires_at.try(:past?)
  end

  def associated?
    identifier.present? && !expired?
  end

  def associate!(redirect_uri)
    config = OpenIDConnect::Discovery::Provider::Config.discover! issuer
    res = RestClient.post config.registration_endpoint, {
      type: 'client_associate',
      application_name: 'NOV RP',
      application_type: 'web',
      redirect_uri: redirect_uri
    }
    credentials = JSON.parse(res.body).with_indifferent_access
    self.attributes = {
      identifier:             credentials[:client_id],
      secret:                 credentials[:client_secret],
      scope:                  config.scopes_supported.join(' '),
      authorization_endpoint: config.authorization_endpoint,
      token_endpoint:         config.token_endpoint,
      check_id_endpoint:      config.check_id_endpoint,
      user_info_endpoint:     config.user_info_endpoint,
      dynamic:                true,
      expires_at:             attributes[:expires_in].try(:from_now)
    }
    save!
  end

  def self.discover!(host)
    issuer = OpenIDConnect::Discovery::Provider.discover!(host).location
    if provider = find_by_issuer(issuer)
      provider
    else
      create(
        issuer: issuer,
        name: host
      )
    end
  end

  def as_json(options = {})
    [
      :identifier, :secret, :scope, :host, :scheme,
      :authorization_endpoint, :token_endpoint, :check_id_endpoint, :user_info_endpoint
    ].inject({}) do |hash, key|
      hash.merge!(
        key => self.send(key)
      )
    end
  end

  def check_id!(id_token)
    raise OpenIDConnect::Exception.new('No ID Token was given.') if id_token.blank?
    OpenIDConnect::ResponseObject::IdToken.decode(
      id_token, client
    )
  end

  def client
    @client ||= OpenIDConnect::Client.new as_json
  end

  def authorization_uri(redirect_uri)
    client.redirect_uri = redirect_uri
    client.authorization_uri(
      response_type: :code,
      scope: scope
    )
  end

  def authenticate(redirect_uri, code)
    client.redirect_uri = redirect_uri
    client.authorization_code = code
    access_token = client.access_token!
    id_token = check_id! access_token.id_token
    open_id = self.open_ids.find_or_initialize_by_identifier id_token.user_id
    open_id.access_token, open_id.id_token = access_token.access_token, access_token.id_token
    open_id.save!
    open_id.account || Account.create!(open_id: open_id)
  end
end
