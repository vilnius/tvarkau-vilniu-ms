class Reports::Create
  include Interactor::Initializer

  initialize_with :user, :params

  def run
    validate

    return report if report.errors.any?

    report.save
    report
  end

  private

  def validate
    report.validate

    return unless report.report_type&.requires_license_plate_no?

    report.errors.add(:base, I18n.t('error.viisp_required')) unless user.personal_code?
  end

  def report
    @report ||= build_report
  end

  def build_report
    user.reports.new(params) do |o|
      o.city_id = o.report_type&.city_id
      o.report_status = ReportStatus.registered
    end
  end
end
