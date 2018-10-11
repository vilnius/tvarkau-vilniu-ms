class Reports::Create
  include Interactor::Initializer

  initialize_with :user, :params

  def run
    report = build_report

    return report unless report.valid?

    report.save
    report
  end

  private

  def build_report
    user.reports.new(params) do |o|
      o.city_id = o.report_type&.city_id
      o.report_status = ReportStatus.registered
    end
  end
end
