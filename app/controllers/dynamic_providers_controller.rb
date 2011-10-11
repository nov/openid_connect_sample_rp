class DynamicProvidersController < ApplicationController
  rescue_from OpenIDConnect::Discovery::DiscoveryFailed, OpenIDConnect::Discovery::InvalidIdentifier do |e|
    flash[:error] = {
      title: 'Discovery Failed',
      text: e.message
    }
    redirect_to root_url
  end

  def create
    provider = Provider.discover! params[:host]
    provider.associate! provider_open_id_url('__provider_id__')
    redirect_to provider.authorization_uri(
      provider_open_id_url(provider)
    )
  rescue => e
    logger.info e.message
    raise e
  end
end
