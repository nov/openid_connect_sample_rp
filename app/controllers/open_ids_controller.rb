class OpenIdsController < ApplicationController
  before_filter :require_anonymous_access

  def show
    authenticate OpenId.authenticate(params[:code])
    redirect_to account_url
  end

  def create
    redirect_to OpenId.authorization_uri
  end
end
