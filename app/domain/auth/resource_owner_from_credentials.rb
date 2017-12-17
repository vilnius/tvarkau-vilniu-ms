# frozen_string_literal: true

class Auth::ResourceOwnerFromCredentials
  include Interactor::Initializer

  initialize_with :request

  GUEST = 'guest'

  def run
    return guest_user if guest?

    authenticated_user
  end

  private

  def guest_user
    Users::CreateGuest.run
  end

  def authenticated_user
    user = User.find_for_authentication(email: username)
    user if user&.valid_password?(password)
  end

  def guest?
    username == GUEST
  end

  def username
    request.params[:username]
  end

  def password
    request.params[:password]
  end
end
