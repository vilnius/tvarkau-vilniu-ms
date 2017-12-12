class Api::ReportsController < Api::BaseController
  def index
    reports = ::Reports::Filter.for(filter_params)

    { entries: reports }
  end

  def show
    Report.find(params[:id])
  end

  def create

    report = ::Reports::Create.for(current_user.reports.new, report_params)
    return render_record_validation_error(report) if report.errors.any?
    report
  end

  private

  def report_params
    params.require(:report)
  end

  def filter_params
    params.permit(:start, :limit, :type, :status)
  end
end
