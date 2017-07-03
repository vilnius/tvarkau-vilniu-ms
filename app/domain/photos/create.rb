class Photos::Create
  def self.for(file_data)
    new(file_data).run
  end

  attr_reader :file_data

  def initialize(file_data)
    @file_data = file_data
  end

  def run
    return unless upload
    photo_uuid
  end

  private

  def upload
    PhotoService.upload_photo(photo_uuid, file)
  end

  def photo_uuid
    @photo_uuid ||= SecureRandom.uuid
  end

  def file
    @file ||= file_data[:file]
  end
end
