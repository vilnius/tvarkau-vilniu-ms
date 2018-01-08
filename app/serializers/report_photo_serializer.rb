class ReportPhotoSerializer < ActiveModel::Serializer
  attributes :id,
             :uuid,
             :photo_url,
             :photo_thumb_url

  def photo_thumb_url
    object.photo.thumb.url
  end
end
