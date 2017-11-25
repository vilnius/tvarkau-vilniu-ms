ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

require 'create_without_validation_strategy'
FactoryBot.register_strategy(:create_without_validation, CreateWithoutValidationStrategy)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |c|
    c.syntax = :expect
  end

  config.infer_spec_type_from_file_location!

  config.include(FactoryBot::Syntax::Methods)
  config.include(ApiSpecHelper)

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner[:active_record, { model: TvarkauVilniuDbBase }].strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner[:active_record, { model: TvarkauVilniuDbBase }].start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner[:active_record, { model: TvarkauVilniuDbBase }].start
  end
end
