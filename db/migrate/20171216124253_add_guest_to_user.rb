class AddGuestToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :guest, :boolean, null: false, default: false, after: :email
    add_index :users, :guest
  end
end
