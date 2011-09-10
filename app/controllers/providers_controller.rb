class ProvidersController < ApplicationController
  before_filter :require_authentication

  def new
    @provider = account.providers.new
  end

  def create
    @provider = account.providers.new params[:provider]
    if @provider.save
      flash[:notice] = "#{@provider.name} is registered"
      redirect_to root_url
    else
      flash[:error] = @provider.errors.full_messages.to_sentence
      render :new
    end
  end
end
