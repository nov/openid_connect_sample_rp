class Provider < ActiveRecord::Base
  has_many :open_ids
  belongs_to :account

  validates :name,                   presence: true
  validates :identifier,             presence: true
  validates :authorization_endpoint, presence: true
  validates :token_endpoint,         presence: true
  validates :check_id_endpoint,      presence: true
  validates :user_info_endpoint,     presence: true

  attr_accessor :registration_endpoint

  scope :dynamic,  where(dynamic: true)
  scope :listable, where(dynamic: false)
  scope :valid, lambda {
    where {
      (expires_at == nil) |
      (expires_at >= Time.now.utc)
    }
  }

  def associate!(redirect_uri)
    _endpoint_ = registration_endpoint
    res = RestClient.post _endpoint_, {
      type: 'client_associate',
      application_name: 'NOV RP',
      application_type: 'web',
      redirect_uri: redirect_uri
    }
    attributes = JSON.parse(res.body).with_indifferent_access
    self.identifier = attributes[:client_id]
    self.secret = attributes[:client_secret]
    self.dynamic = true
    if attributes[:expires_in]
      self.expires_at = attributes[:expires_in].from_now
    end
      logger.info _endpoint_
    save!
    # update redirect_uri here
    logger.info _endpoint_
    RestClient.post _endpoint_, {
      type: 'client_update',
      client_id: identifier,
      client_secret: secret,
      redirect_uri: redirect_uri.sub('__provider_id__', self.id.to_s)
    }
  rescue => e
    logger.info e.message
    raise e
  end

  def self.discover!(host)
    config = OpenIDConnect::Discovery::Provider::Config.discover! host
    new(
      name:                   host,
      scope:                  config.scopes_supported.join(' '),
      authorization_endpoint: config.authorization_endpoint,
      token_endpoint:         config.token_endpoint,
      check_id_endpoint:      config.check_id_endpoint,
      user_info_endpoint:     config.user_info_endpoint,
      registration_endpoint:  config.registration_endpoint
    )
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
    OpenIDConnect::ResponseObject::IdToken.from_jwt(
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
