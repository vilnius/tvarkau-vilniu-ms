class Reports::Create
  include Interactor::Initializer

  initialize_with :user, :params

  def run
    return report unless report.valid?

    report.save
    report
  end

  private

  def report
    @report ||= user.reports.new(params)
  end
end
