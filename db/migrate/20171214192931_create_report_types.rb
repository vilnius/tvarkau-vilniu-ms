class CreateReportTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :report_types do |t|
      t.integer :city_id
      t.string :title
      t.string :short_label
      t.timestamps
      t.index :city_id
    end
  end
end
