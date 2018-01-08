class ReportPhoto < ApplicationRecord
  mount_uploader :photo, ReportPhotoUploader
end
