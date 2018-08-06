class OAuthAppsConfidentiality < ActiveRecord::Migration[5.1]
  def up
    execute "UPDATE oauth_applications SET confidential=0 AND scopes='public user'"
  end
end
