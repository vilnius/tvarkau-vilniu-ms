class AddReportCoordsIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :reports, [:lat, :lng]
  end
end
