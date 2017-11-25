class CreateApiAuthTokens < ActiveRecord::Migration[4.2]
  def up
    create_table :api_auth_tokens do |t|
      t.string :token
      t.timestamp :last_used
    end

    add_index :api_auth_tokens, :token, unique: true
  end

  def down
    drop_table :api_auth_tokens
  end
end
