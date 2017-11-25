class DropLocalTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :report_photos
    drop_table :report_types
    drop_table :reports
  end
end
