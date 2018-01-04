CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['STORAGE_ACCESS_KEY'].to_s,
    aws_secret_access_key: Secret['STORAGE_SECRET_KEY'].to_s,
    region: ENV.fetch('STORAGE_REGION', 'us-east-1'),
    endpoint: ENV['STORAGE_ENDPOINT'],
  }

  config.fog_directory = ENV.fetch('STORAGE_BUCKET', 'photos')
end
