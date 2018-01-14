class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.binary :code, limit: 25, null: false
      t.string :name, limit: 50, null: false
      t.decimal :lat, precision: 10, scale: 8
      t.decimal :lng, precision: 11, scale: 8
      t.boolean :active, null: false, default: false
      t.timestamps null: false
      t.index :code, unique: true
    end
  end
end
