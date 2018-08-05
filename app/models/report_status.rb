class ReportStatus < ApplicationRecord
  validates :title, presence: true

  scope :active, -> { where(active: true) }
end
