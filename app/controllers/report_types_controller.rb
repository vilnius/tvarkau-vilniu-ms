class ReportTypesController < ApiController
  def index
    render json: current_city.report_types.all, root: :report_types
  end
end
