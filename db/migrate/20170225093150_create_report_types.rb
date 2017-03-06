class CreateReportTypes < ActiveRecord::Migration
  def change
    create_table :report_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
