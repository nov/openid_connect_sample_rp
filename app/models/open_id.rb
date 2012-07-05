class OpenId < ActiveRecord::Base
  belongs_to :account
  belongs_to :provider

  validates :identifier, uniqueness: {scope: :provider_id}

  def to_access_token
    OpenIDConnect::AccessToken.new(
      access_token: access_token,
      client: provider.client
    )
  end

  def check_id!
    provider.decode_id id_token
  end
end
