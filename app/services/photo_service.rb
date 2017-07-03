class PhotoService
  require 'aws-sdk'
  require 'mimemagic'

  ACCEPTED_CONTENT_TYPES = %w(image/jpeg image/png).freeze
  BUCKET = APP_CONFIG['storage_bucket']

  def self.upload_photo(photo_uuid, uploaded_data)
    # TODO: Add tracking of validation errors
    return false unless accepted_mimetype?(uploaded_data)

    # Prefixing with unique id because duplicates are overwritten
    obj = client.bucket(BUCKET).object(photo_uuid + '_' + uploaded_data.original_filename)

    # Upload the file.
    obj.upload_file(uploaded_data.open)

    # Save the upload details
    @photo = ReportPhoto.new(
      public_url: obj.public_url,
      name: obj.key,
      uuid: photo_uuid
    )
    @photo.save

    true
  end

  def self.accepted_mimetype?(file)
    mime_type = MimeMagic.by_magic(file).to_s
    file.rewind

    ACCEPTED_CONTENT_TYPES.include?(mime_type)
  end

  def self.client
    @client ||= Aws::S3::Resource.new(Aws::S3::Client.new)
  end
end
