CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['STORAGE_ACCESS_KEY'].to_s,
    aws_secret_access_key: Secret['STORAGE_SECRET_KEY'].to_s,
    host: ENV['STORAGE_HOST'],
    endpoint: ENV['STORAGE_ENDPOINT'],
    path_style: true,
  }

  config.fog_directory = ENV.fetch('STORAGE_BUCKET', 'uploads')
end
