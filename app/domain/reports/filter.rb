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
    scope = Report.offset(offset).limit(per_page).order(id: :desc)
    scope = scope.where(user_id: params[:user_id]) if params[:user_id].present?
    scope = scope.where(report_status_id: params[:status]) if params[:status].present?
    scope = scope.where(report_type_id: params[:type]) if params[:type].present?
    scope = scope.where(lat: lat_range, lng: lng_range) if lat_range && lng_range
    scope.to_a
  end

  private

  def offset
    page.to_i * per_page.to_i
  end

  def per_page
    params[:per_page] || DEFAULT_PER_PAGE
  end

  def lat_range
    return if params[:lat_from].blank?
    return if params[:lat_to].blank?

    BigDecimal(params[:lat_from].to_s)..BigDecimal(params[:lat_to].to_s)
  end

  def lng_range
    return if params[:lng_from].blank?
    return if params[:lng_to].blank?

    BigDecimal(params[:lng_from].to_s)..BigDecimal(params[:lng_to].to_s)
  end

  def page
    params[:page] || 0
  end
end
