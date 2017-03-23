class CreateApiAuthTokens < ActiveRecord::Migration
  def up
    create_table :api_auth_tokens do |t|
      t.string :token
      t.timestamp :last_used, default: nil
    end

    add_index :api_auth_tokens, :token, unique: true
  end

  def down
    drop_table :api_auth_tokens
  end
end
