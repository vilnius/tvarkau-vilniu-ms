class Api::ReportsController < Api::BaseController
  def index
    { :entries => Report.all }
  end

  def show
    @report = Report.find_by_id(params[:id])
    render_404 unless @report

    { :report => @report }
  end
end
