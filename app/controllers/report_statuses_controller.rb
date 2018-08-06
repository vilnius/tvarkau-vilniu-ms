class ReportStatusesController < ApiController
  def index
    render json: ReportStatus.active.all, root: :report_statuses
  end
end
