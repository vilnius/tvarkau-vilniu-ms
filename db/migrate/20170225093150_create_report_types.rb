class CreateReportTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :report_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
