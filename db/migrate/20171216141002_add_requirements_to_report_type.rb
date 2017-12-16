class AddRequirementsToReportType < ActiveRecord::Migration[5.1]
  def change
    rename_column :reports, :car_plate_no, :license_plate_no

    change_table :report_types do |t|
      t.integer :requires_photos, null: false, default: 0, after: :short_label
      t.boolean :requires_viisp_auth, null: false, default: 0, after: :requires_photos
      t.boolean :requires_license_plate_no, null: false, default: false, after: :requires_viisp_auth
      t.boolean :requires_registered_at, null: false, default: false, after: :requires_license_plate_no
    end
  end
end
