class ReportStatus < ApplicationRecord
  validates :title, presence: true

  scope :active, -> { where(active: true) }

  def self.registered
    find_by(avilys_status: 'registered')
  end
end
