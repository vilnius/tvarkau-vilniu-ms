class Report < ApplicationRecord
  belongs_to :user
  belongs_to :report_type
  belongs_to :status, class_name: 'StatusType'

  validates :description,
            :address,
            :report_type,
            :status,
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

  # belongs_to :main_cfg, class_name: 'MainCfg', foreign_key: 'CITY_ID'
end
