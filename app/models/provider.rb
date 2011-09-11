class Provider < ActiveRecord::Base
  has_many :open_ids

  validates :name,                   presence: true
  validates :identifier,             presence: true
  validates :authorization_endpoint, presence: true
  validates :token_endpoint,         presence: true
  validates :check_session_endpoint, presence: true
  validates :user_info_endpoint,     presence: true

  extend ActiveSupport::Memoizable

  def as_json(options = {})
    [
      :identifier, :secret, :scope, :host, :scheme,
      :authorization_endpoint, :token_endpoint, :check_session_endpoint, :user_info_endpoint, :public_key_endpoint
    ].inject({}) do |hash, key|
      hash.merge!(
        key => self.send(key)
      )
    end
  end

  def check_session!(id_token)
    raise OpenIDConnect::Exception.new('No ID Token was given.') if id_token.blank?
    OpenIDConnect::ResponseObject::IdToken.from_jwt(
      id_token, public_key || client
    )
  end

  def public_key
    if public_key_endpoint.present?
      pem = HTTPClient.get_content client.send(:absolute_uri_for, public_key_endpoint)
      to_public_key pem
    end
  rescue OpenSSL::PKey::RSAError
    nil
  end
  memoize :public_key

  def client
    @client ||= OpenIDConnect::Client.new as_json
  end

  def authorization_uri(redirect_uri)
    client.redirect_uri = redirect_uri
    client.authorization_uri(
      response_type: [:code, :id_token],
      scope: scope
    )
  end

  def authenticate(redirect_uri, code)
    client.redirect_uri = redirect_uri
    client.authorization_code = code
    access_token = client.access_token!
    id_token = check_session! access_token.id_token
    open_id = self.open_ids.find_or_initialize_by_identifier id_token.user_id
    open_id.access_token, open_id.id_token = access_token.access_token, access_token.id_token
    open_id.save!
    open_id.account || Account.create!(open_id: open_id)
  end

  private

  def to_public_key(pem)
    OpenSSL::PKey::RSA.new pem
  rescue OpenSSL::PKey::RSAError
    OpenSSL::X509::Certificate.new(pem).public_key
  end
end
