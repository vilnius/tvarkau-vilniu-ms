Aws.config.update(
  region: 'us-east-1',
  endpoint: APP_CONFIG['storage_endpoint'],
  force_path_style: true,
  credentials: Aws::Credentials.new(
    APP_CONFIG['storage_access_key'],
    APP_CONFIG['storage_secret_key']
  )
)
