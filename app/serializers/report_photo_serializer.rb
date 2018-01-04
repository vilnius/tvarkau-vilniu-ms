class ReportPhotoSerializer < ActiveModel::Serializer
  attributes :id,
             :uuid,
             :photo_url
end
