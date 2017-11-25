class AddReportTypeToReport < ActiveRecord::Migration[4.2]
  def change
    add_reference :reports, :report_type, index: true
    change_column :reports, :report_type_id, :integer, null: false
  end
end
