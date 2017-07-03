class CreateReportPhotos < ActiveRecord::Migration
  def up
    create_table :report_photos do |t|
      t.string :uuid
      t.string :public_url
      t.string :name

      t.timestamps null: false
    end
  end

  def down
    drop_table :report_photos
  end
end
