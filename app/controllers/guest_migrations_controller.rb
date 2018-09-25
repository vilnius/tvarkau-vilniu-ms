class GuestMigrationsController < ApiController
  class MigrationError < StandardError; end

  def create
    Users::MigrateGuest.run(current_user, guest_token)

    render json: { success: true }
  rescue Errors::GuestMigrationError => e
    render_api_error VALIDATION_ERROR, e.message
  end

  private

  def guest_token
    @guest_token ||= Doorkeeper::AccessToken.find_by!(token: params[:guest_token])
  end
end
