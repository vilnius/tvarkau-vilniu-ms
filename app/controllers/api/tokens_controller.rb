class Api::TokensController < Api::BaseController
  require 'securerandom'

  skip_before_action :load_token

  def create
    { token: api_auth_token }
  end

  private

  def api_auth_token
    @token ||= ApiAuthToken.new.tap do |auth_token|
      auth_token.token = SecureRandom.uuid
      auth_token.last_used = DateTime.current
      auth_token.save
    end
  end
end
