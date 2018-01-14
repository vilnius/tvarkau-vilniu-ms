class ReportType < ApplicationRecord
  belongs_to :city

  validates :title, presence: true
end
