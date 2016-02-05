class ApplicationController < ActionController::Base
  include Authentication
  include Nonce
  include Notification

  rescue_from(
    Rack::OAuth2::Client::Error,
    OpenIDConnect::Exception,
    Nonce::Exception,
    MultiJson::LoadError,
    OpenSSL::SSL::SSLError
  ) do |e|
    flash[:error] = if e.message.length > 2000
      'Unknown Error'
    else
      e.message
    end
    unauthenticate!
    redirect_to root_url
  end

  protect_from_forgery
end
