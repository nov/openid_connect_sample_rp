source 'http://rubygems.org'

gem 'jquery-rails'
gem 'openid_connect'
gem 'html5_validators'
gem 'squeel'
gem 'rails', '~>4.2'
gem 'rest-client'

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'turn', require: false
end

group :production do
  gem 'pg'
  gem 'rack-ssl', require: 'rack/ssl'
end
