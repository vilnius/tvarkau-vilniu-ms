class Reports::Filter

  DEFAULT_LIMIT = 20

  def self.for(params)
    new(params).run
  end

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def run
    scope = Report.offset(offset).limit(limit)
    scope = scope.where(report_status_id: params[:status]) if params[:status].present?
    scope = scope.where(report_type_id: params[:type]) if params[:type].present?
    scope.to_a
  end

  private

  def limit
    params[:limit] || DEFAULT_LIMIT
  end

  def offset
    params[:start] || 0
  end
end
