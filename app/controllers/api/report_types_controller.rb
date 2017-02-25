class Api::ReportTypesController < Api::BaseController
  def index
    { :entries => ReportType.select(:id, :title) }
  end
end
