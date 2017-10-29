class Api::ReportTypesController < Api::BaseController
  def index
    { entries: ReportType.select(:ID, :problem_type) }
  end
end
