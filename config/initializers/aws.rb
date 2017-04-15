Aws.config.update(
  region: 'us-east-1',
  endpoint: ENV['MINIO_ENDPOINT'],
  force_path_style: true,
  credentials: Aws::Credentials.new(
    ENV['MINIO_ACCESS_KEY'],
    ENV['MINIO_SECRET_KEY']
  )
)
