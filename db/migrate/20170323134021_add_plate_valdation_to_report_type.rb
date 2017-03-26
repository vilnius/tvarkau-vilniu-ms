class AddPlateValdationToReportType < ActiveRecord::Migration
  def up
    add_column :report_types, :validate_plate, :boolean, default: false
  end

  def down
    remove_column :report_types, :validate_plate
  end
end
