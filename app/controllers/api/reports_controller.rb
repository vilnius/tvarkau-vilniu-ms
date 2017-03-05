class Api::ReportsController < Api::BaseController

  def index
    { :entries => Report.all }
  end

  def show
    report = Report.find_by_id(params[:id])
    render_404 unless report

    { :report => report }
  end

  def create
    report = ::Reports::Create.for(Report.new, report_params)
    return render_record_validation_error(report) if report.errors.any?

    { :report => report }
  end

  private

  def report_params
    params.require(:report)
  end
end