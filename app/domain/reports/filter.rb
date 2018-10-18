class Reports::Filter

  DEFAULT_PER_PAGE = 20

  def self.for(params)
    new(params).run
  end

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def run
    scope = Report.offset(offset).limit(per_page).order(registered_at: :desc)
    scope = scope.where(user_id: params[:user_id]) if params[:user_id].present?
    scope = scope.where(report_status_id: params[:status]) if params[:status].present?
    scope = scope.where(report_type_id: params[:type]) if params[:type].present?
    scope.to_a
  end

  private

  def offset
    page.to_i * per_page.to_i
  end

  def per_page
    params[:per_page] || DEFAULT_PER_PAGE
  end

  def page
    params[:page] || 0
  end
end
