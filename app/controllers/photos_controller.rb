class PhotosController < ApiController
  def create
    temp_uuid = Photos::Create.for(photo_params)
    return { photo_uuid: temp_uuid } if temp_uuid.present?

    render_api_error(VALIDATION_ERROR, I18n.t('error.uploading_photo'))
  end

  private

  def photo_params
    params.require(:photo).permit(:file)
  end
end
