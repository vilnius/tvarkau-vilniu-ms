class ReportPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  # def fog_directory
  #   'uploads'
  # end

  def store_dir
    model.class.name.tableize
  end

  def filename
    "#{model.id}_#{original_filename}"
  end

  def content_type_whitelist
    %w[image/jpeg image/png]
  end
end
