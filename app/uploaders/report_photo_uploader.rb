class ReportPhotoUploader < CarrierWave::Uploader::Base
  storage :fog

  def content_type_whitelist
    %w[image/jpeg image/png]
  end
end
