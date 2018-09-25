# frozen_string_literal: true

class Users::MigrateGuest
  include Interactor::Initializer

  initialize_with :user, :guest_token

  def run
    return unless guest_token.resource_owner_id

    validate!

    User.transaction do
      guest_user.reports.update_all(user_id: user.id)
      guest_user.destroy
      guest_token.destroy
    end
  end

  private

  def validate!
    raise GuestMigrationError, 'Current user is guest' if user.guest?
  end

  def guest_user
    @guest_user ||= User.guests.find_by!(id: guest_token.resource_owner_id)
  end
end
