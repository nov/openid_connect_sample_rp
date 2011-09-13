class ProvidersController < ApplicationController
  before_filter :require_authentication

  def index
    @providers = current_account.providers
  end

  def new
    @provider = discover params[:host]
  end

  def create
    @provider = current_account.providers.new params[:provider]
    if @provider.save
      flash[:notice] = "#{@provider.name} is registered"
      redirect_to providers_url
    else
      flash[:error] = @provider.errors.full_messages.join('<br>')
      render :new
    end
  end

  def edit
    @provider = current_account.providers.find params[:id]
  end

  def update
    @provider = current_account.providers.find params[:id]
    if @provider.update_attributes params[:provider]
      flash[:notice] = "#{@provider.name} is updated"
      redirect_to providers_url
    else
      flash[:error] = @provider.errors.full_messages.join('<br>')
      render :edit
    end
  end

  def destroy
    @provider = current_account.providers.find params[:id]
    @provider.destroy
    redirect_to providers_url
  end

  private

  def discover(host)
    Provider.discover! host
  rescue OpenIDConnect::Discovery::DiscoveryFailed, OpenIDConnect::Discovery::InvalidIdentifier => e
    flash[:error] = {
      title: 'Discovery Failed',
      text: ' Please configure your provider manually.'
    }
    Provider.new(
      name: host
    )
  end
end
