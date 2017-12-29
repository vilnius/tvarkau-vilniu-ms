Aws.config.update(
  region: ENV.fetch('STORAGE_REGION', 'us-east-1'),
  endpoint: ENV['STORAGE_ENDPOINT'],
  force_path_style: true,
  credentials: Aws::Credentials.new(
    ENV['STORAGE_ACCESS_KEY'],
    Secret['STORAGE_SECRET_KEY']
  )
)
