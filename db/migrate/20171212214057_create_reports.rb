class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :ref_no, limit: 50, null: false
      t.integer :report_type_id, null: false
      t.integer :status_id, null: false
      t.integer :user_id

      t.text :description
      t.text :answer, limit: 100.kilobytes

      t.string :car_plate_no

      t.decimal :lat, precision: 10, scale: 8
      t.decimal :lng, precision: 11, scale: 8

      t.datetime :registered_at
      t.datetime :completed_at
      t.timestamps

      t.index :user_id
      t.index :report_type_id
      t.index :ref_no, unique: true
    end
  end
end
