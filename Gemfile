source 'https://rubygems.org'

gem 'rails', '5.1.4'
gem 'rails-i18n', '~> 5.1'
gem 'mysql2'
gem 'active_model_serializers', '~> 0.10'
gem 'puma', '~> 3.11'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
gem 'interactor-initializer', '~> 0.2'
gem 'doorkeeper', '~> 5.0.0'
gem 'doorkeeper-grants_assertion', '~> 0.2'
gem 'devise', '~> 4.4.0'
gem 'omniauth-google-oauth2', '~> 0.5'
gem 'omniauth-facebook', '~> 4.0'
gem 'jwt'
gem 'koala', '~> 3.0'
gem 'faraday'
gem 'viisp-auth', '~> 0.1'
gem 'carrierwave', '~> 1.2'
gem 'fog-aws', '~> 2.0'
gem 'mini_magick', '~> 4.8'
gem 'factory_bot_rails'

# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'spring-commands-rspec'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-collection_matchers'
  gem 'database_cleaner'
  gem 'pronto', '~> 0.8'
  gem 'pronto-brakeman', '~> 0.8', require: false
  gem 'pronto-flay', '~> 0.8', require: false
  gem 'pronto-rails_schema', '~> 0.8', require: false
  gem 'pronto-rubocop', '~> 0.8', require: false
  gem 'shoulda-matchers'
  gem 'listen'
  gem 'oauth2'
  gem 'dotenv-rails', '~> 2.2'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'webmock', require: false
end
