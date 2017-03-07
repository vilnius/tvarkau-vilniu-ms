class AddAnswerToReports < ActiveRecord::Migration
  def up
    add_column :reports, :answer, :string
  end

  def down
    remove_column :reports, :answer
  end
end
