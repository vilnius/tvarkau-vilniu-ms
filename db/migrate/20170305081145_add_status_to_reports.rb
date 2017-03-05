class AddStatusToReports < ActiveRecord::Migration
  def up
    add_column :reports, :status, :integer, null: false
  end

  def down
    remove_column :reports, :status
  end
end
