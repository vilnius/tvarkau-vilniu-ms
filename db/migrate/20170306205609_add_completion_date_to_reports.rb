class AddCompletionDateToReports < ActiveRecord::Migration[4.2]
  def up
    add_column :reports, :complete_date, :timestamp
  end

  def down
    remove_column :reports, :complete_date
  end
end
