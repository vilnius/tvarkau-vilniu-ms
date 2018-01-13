class ReportPhotosController < ApiController
  def create
    render json: ReportPhotos::Create.run(photo_params[:file])
  rescue ActiveRecord::RecordInvalid
    render_api_error(VALIDATION_ERROR, t('error.uploading_photo'))
  end

  private

  def photo_params
    params.require(:report_photo).permit(:file)
  end
end
