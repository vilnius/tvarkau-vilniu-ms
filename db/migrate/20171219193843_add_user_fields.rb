class AddUserFields < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :email, :string, null: true, default: nil

    change_table :users do |t|
      t.integer :personal_code, limit: 8, unique: true, after: :email
      t.string :facebook_id, unique: true, limit: 100, after: :personal_code
      t.string :google_id, unique: true, limit: 100, after: :facebook_id
      t.integer :city_id, after: :google_id
      t.string :name, after: :city_id
      t.string :phone, limit: 15, after: :name
      t.string :address, after: :phone
      t.boolean :blacklisted, null: false, default: false, after: :guest

      t.index :personal_code, unique: true
      t.index :facebook_id, unique: true
      t.index :google_id, unique: true
      t.index :city_id
    end
  end
end
