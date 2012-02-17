class OpenIdsController < ApplicationController
  before_filter :require_anonymous_access

  def show
    provider = Provider.find params[:provider_id]
    authenticate provider.authenticate(
      provider_open_id_url(provider),
      params[:code],
      stored_nonce
    )
    redirect_to account_url
  end

  def create
    provider = Provider.find params[:provider_id]
    redirect_to provider.authorization_uri(
      provider_open_id_url(provider),
      new_nonce
    )
  end
end
