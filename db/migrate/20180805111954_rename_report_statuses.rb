class RenameReportStatuses < ActiveRecord::Migration[5.1]
  def change
    rename_table :statuses, :report_statuses
    rename_column :reports, :status_id, :report_status_id
  end
end
