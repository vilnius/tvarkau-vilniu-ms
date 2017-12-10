source 'https://rubygems.org'

gem 'rails', '5.1.4'
gem 'mysql2'
gem 'active_model_serializers', '~> 0.10'
gem 'puma', '~> 3.11'
gem 'aws-sdk', '~> 2'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
gem 'interactor-initializer', '~> 0.2'
gem 'doorkeeper', '~> 4.2.6'
gem 'devise', '~> 4.3.0'
gem 'jwt', '~> 2.1'
gem 'koala', '~> 3.0'
gem 'faraday'

# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_bot_rails'
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
  gem 'capistrano', '~> 3.10', require: false
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'webmock', require: false
end
