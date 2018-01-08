module ReportPhotos::Create
  module_function

  def run(file)
    report_photo = ReportPhoto.new
    report_photo.photo = file
    report_photo.uuid = SecureRandom.uuid
    report_photo.save!
    report_photo
  end
end
