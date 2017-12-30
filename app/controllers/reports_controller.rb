class ReportsController < ApiController
  def index
    reports = ::Reports::Filter.for(filter_params)

    { entries: reports }
  end

  def show
    Report.find(params[:id])
  end

  def create
    report = ::Reports::Create.run(current_user, report_params)
    return render_record_validation_error(report) if report.errors.any?
    report
  end

  private

  def report_params
    params
      .require(:report)
      .permit(
        :report_type_id,
        :status_id,
        :description,
        :lat,
        :lng,
        :address,
        :license_plate_no,
        :registered_at,
      )
  end

  def filter_params
    params.permit(:start, :limit, :type, :status)
  end
end
