class ReportsController < ApiController
  def index
    reports = ::Reports::Filter.for(filter_params)

    render json: reports, root: :reports
  end

  def show
    render json: Report.find(params[:id])
  end

  def create
    report = ::Reports::Create.run(current_user, report_params)
    return render_record_validation_error(report) if report.errors.any?
    render json: report
  end

  private

  def report_params
    params
      .require(:report)
      .permit(
        :report_type_id,
        :description,
        :lat,
        :lng,
        :address,
        :license_plate_no,
        :violation_timestamp,
      )
  end

  def filter_params
    params.permit(:page, :per_page, :type, :status, :user_id)
  end
end
