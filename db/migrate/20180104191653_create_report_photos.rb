class CreateReportPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :report_photos do |t|
      t.string :uuid, null: false
      t.integer :report_id
      t.json :photo
      t.timestamps
      t.index :uuid, unique: true
      t.index :report_id
    end
  end
end
