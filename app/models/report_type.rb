class ReportType < ActiveRecord::Base
  validates :title, presence: true
end
