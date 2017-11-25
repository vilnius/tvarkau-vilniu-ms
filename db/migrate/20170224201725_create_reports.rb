class CreateReports < ActiveRecord::Migration[4.2]
  def change
    create_table :reports do |t|
      t.string :ref_no
      t.string :description
      t.string :address
      t.decimal :lat
      t.decimal :lng
      t.timestamp :report_date

      t.timestamps null: false
    end
    add_index :reports, :ref_no, unique: true
  end
end
