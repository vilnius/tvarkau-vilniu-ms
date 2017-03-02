class Reports::Create

  def self.for(report, params)
    new(report, params).run
  end

  attr_reader :report, :params

  def initialize(report, params)
    @report, @params = report, params
  end

  def run
    report.description = description
    report.address = address
    report.lat = latitude
    report.lng = longitude
    report.report_type_id = report_type_id

    report.valid?

    return report if report.errors.any?

    report.save
    report
  end

  private

  def description
    params[:description]
  end

  def address
    params[:address]
  end

  def latitude
    params[:latitude]
  end

  def longitude
    params[:longitude]
  end

  def report_type_id
    params[:report_type_id]
  end
end