class ProvidersController < ApplicationController
  rescue_from OpenIDConnect::Discovery::DiscoveryFailed, OpenIDConnect::Discovery::InvalidIdentifier do |e|
    flash[:error] = {
      title: 'Discovery Failed',
      text: 'Could not discover your OP.'
    }
    redirect_to root_url
  end

  def create
    provider = Provider.discover! params[:host]
    unless provider.registered?
      provider.register! provider_open_id_url(provider)
    end
    redirect_to provider.authorization_uri(
      provider_open_id_url(provider),
      new_nonce
    )
  end
end
