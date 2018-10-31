# frozen_string_literal: true

class RemoveReportRegisteredAt < ActiveRecord::Migration[5.1]
  def change
    remove_column :reports, :registered_at
    remove_column :report_types, :requires_registered_at
  end
end
