class City < ApplicationRecord
  has_many :report_types
  has_many :reports
  has_many :users

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true

  validates :lat,
            numericality: {
              greater_than_or_equal_to: -90,
              less_than_or_equal_to: 90
            }

  validates :lng,
            numericality: {
              greater_than_or_equal_to: -180,
              less_than_or_equal_to: 180
            }
end
