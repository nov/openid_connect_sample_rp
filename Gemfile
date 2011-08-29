source 'http://rubygems.org'

gem 'rails', '3.0.10'
gem 'jquery-rails'
gem 'openid_connect'

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'turn', :require => false
end

group :production do
  gem 'pg'
  gem 'rack-ssl', :require => 'rack/ssl'
end