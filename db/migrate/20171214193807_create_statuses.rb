class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :title, null: false
      t.string :color, limit: 7, null: false
      t.string :avilys_status, null: false
      t.boolean :active, null: false
      t.timestamps
      t.index :active
    end
  end
end
