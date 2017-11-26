class Api::ReportsController < Api::BaseController
  def index
    { entries: ::Reports::Dto.for(::Reports::Filter.for(filter_params)) }
  end

  def show
    report = Report.find_by_id(params[:id])
    render_404 unless report

    ::Reports::Dto.for(report)
  end

  def create
    report = ::Reports::Create.for(Report.new, report_params)
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
