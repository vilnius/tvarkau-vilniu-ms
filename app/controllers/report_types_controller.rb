class ReportTypesController < ApiController
  def index
    { entries: ReportType.select(:ID, :problem_type) }
  end
end
