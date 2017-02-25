class AddReportTypeToReport < ActiveRecord::Migration
  def change
    add_reference :reports, :report_types, index: true
    change_column :reports, :report_types_id, :integer, null: false
  end
end