class AddStatusToReports < ActiveRecord::Migration[4.2]
  def up
    add_column :reports, :status, :integer, null: false
  end

  def down
    remove_column :reports, :status
  end
end
