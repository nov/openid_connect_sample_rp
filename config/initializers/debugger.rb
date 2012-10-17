OpenIDConnect.logger = SWD.logger = Rack::OAuth2.logger = Rails.logger
OpenIDConnect.debug!

# SWD.url_builder = URI::HTTP if Rails.env.development?