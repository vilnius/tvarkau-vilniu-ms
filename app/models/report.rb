class Report < ActiveRecord::Base
  STATUS_CREATED = 10
  STATUS_REGISTERED = 20
  STATUS_IN_PROGRESS = 30
  STATUS_POSTPONED = 40
  STATUS_SOLVED = 50

  validates :description,
            :address,
            :report_type_id,
            presence: true

  validates :lat,
            presence: true,
            numericality: {
              greater_than_or_equal_to: -90,
              less_than_or_equal_to: 90
            }

  validates :lng,
            presence: true,
            numericality: {
              greater_than_or_equal_to: -180,
              less_than_or_equal_to: 180
            }

  validate :report_type_validation

  belongs_to :report_type

  after_initialize :defaults, unless: :persisted?

  scope :filtered_status, -> (statuses) { where('status in (?)', statuses) if statuses.present? && statuses.any? }
  scope :filtered_type, -> (types) { where('report_type_id in (?)', types) if types.present? && types.any? }

  private

  def defaults
    self.status = STATUS_CREATED
  end

  def report_type_validation
    #avoid double errors and back out early. Presence validator will validate nil
    return if report_type_id.nil?

    if ReportType.find_by_id(report_type_id).nil?
      errors.add(:report_type, I18n.t('error.report_type.non_existing'))
    end
  end
end
