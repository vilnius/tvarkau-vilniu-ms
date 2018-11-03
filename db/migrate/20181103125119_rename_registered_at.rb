class RenameRegisteredAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :reports, :registered_at, :violation_timestamp
    rename_column :report_types, :requires_registered_at, :requires_violation_timestamp
  end
end
