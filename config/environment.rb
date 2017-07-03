# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
template = ERB.new File.new(Rails.root.join('config', 'config.yml')).read
APP_CONFIG = YAML.load(template.result(binding))[Rails.env]

# Initialize the Rails application.
Rails.application.initialize!
