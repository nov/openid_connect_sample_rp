class OpenId < ActiveRecord::Base
  belongs_to :account

  def to_access_token
    OpenIDConnect::AccessToken.new(
      access_token: access_token,
      client: self.class.client
    )
  end

  def parsed_id_token
    OpenIDConnect::ResponseObject::IdToken.from_jwt(
      id_token, self.class.public_key
    ).as_json
  end

  class << self
    extend ActiveSupport::Memoizable

    def config
      YAML.load_file("#{Rails.root}/config/open_id.yml")[Rails.env].symbolize_keys
    end
    memoize :config

    def public_key
      _public_key_ = HTTPClient.get_content client.send(:absolute_uri_for, config[:public_key_endpoint])
      OpenSSL::PKey::RSA.new _public_key_
    end
    memoize :public_key

    def client
      @client ||= OpenIDConnect::Client.new config
    end

    def authorization_uri
      client.authorization_uri(
        response_type: :code,
        scope: config[:scope]
      )
    end

    def authenticate(code)
      client.authorization_code = code
      access_token = client.access_token!
      id_token = OpenIDConnect::ResponseObject::IdToken.from_jwt access_token.id_token, public_key
      open_id = find_or_initialize_by_identifier id_token.user_id
      open_id.access_token, open_id.id_token = access_token.access_token, access_token.id_token
      open_id.save!
      open_id.account || Account.create!(open_id: open_id)
    end
  end
end
