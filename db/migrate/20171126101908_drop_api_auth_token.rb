class DropApiAuthToken < ActiveRecord::Migration[5.1]
  def change
    drop_table :api_auth_tokens
  end
end
