class AddAnswerToReports < ActiveRecord::Migration[4.2]
  def up
    add_column :reports, :answer, :string
  end

  def down
    remove_column :reports, :answer
  end
end
