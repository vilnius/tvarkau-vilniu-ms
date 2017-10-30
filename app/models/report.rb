class Report < TvarkauVilniuDbBase
  self.table_name = 'PRS_REG_PROBLEMS'

  alias_attribute :id, :ID
  alias_attribute :description, :DESCRIPTION
  alias_attribute :address, :ADDRESS
  alias_attribute :lat, :COORDS_GOOGLE_LAT
  alias_attribute :lng, :COORDS_GOOGLE_LNG
  alias_attribute :report_date, :REG_DATE
  alias_attribute :user_id, :USER_ID
  alias_attribute :version, :VERSION

  # Unused
  alias_attribute :lks_x, :COORDS_LKS_X
  alias_attribute :lks_y, :COORDS_LKS_Y
  alias_attribute :postcode, :ADDRESS_POSTCODE
  alias_attribute :address_street, :ADDRESS_STREET
  alias_attribute :address_house_no, :ADDRESS_HOUSE_NO

  DEFAULT_USER_ID = 1

  STATUS_REGISTERED = 1
  STATUS_IN_PROGRESS = 2
  STATUS_RESOLVED = 3
  STATUS_POSTPONED = 4
  STATUS_FORWARDED = 5

  validates :description,
            :address,
            :report_type,
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

  belongs_to :report_type, class_name: 'ReportType', foreign_key: 'PROBLEM_TYPE_ID'
  belongs_to :status_type, class_name: 'StatusType', foreign_key: 'STATUS_ID'
  belongs_to :main_cfg, class_name: 'MainCfg', foreign_key: 'CITY_ID'

  after_initialize :defaults, unless: :persisted?

  scope :filtered_status, lambda { |statuses|
    where('status_id in (?)', statuses) if statuses.present? && statuses.any?
  }
  scope :filtered_type, lambda { |types|
    where('problem_type_id in (?)', types) if types.present? && types.any?
  }

  private

  def defaults
    self.user_id = DEFAULT_USER_ID
    self.lks_x = 0
    self.lks_y = 0
    self.postcode = ''
    self.address_street = ''
    self.address_house_no = ''
  end

  def report_type_validation
    # Avoid double errors and back out early. Presence validator will validate nil
    return unless report_type.nil?

    errors.add(:report_type, I18n.t('error.report_type.non_existing'))
  end
end
