class ReportPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  def content_type_whitelist
    %w[image/jpeg image/png]
  end
end
