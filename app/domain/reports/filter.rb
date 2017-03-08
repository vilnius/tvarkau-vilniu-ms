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
    Report.limit(limit)
      .offset(offset)
      .filtered_status([*params[:status]])
      .filtered_type(*[params[:type]])
      .to_a
  end

  private

  def limit
    params[:limit] || DEFAULT_LIMIT
  end

  def offset
    params[:start] || 0
  end
end
