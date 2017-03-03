class Report < ActiveRecord::Base

  validates :description,
            :address,
            :report_type_id,
            :lat, :lng, presence: true

  validate :report_type_validation

  belongs_to :report_type

  private

  def report_type_validation
    #avoid double errors and back out early. Presence validator will validate nil
    return if report_type_id.nil?

    if ReportType.find_by_id(report_type_id).nil?
      errors.add(:report_type, I18n.t('error.report_type.non_existing'))
    end
  end
end
