# frozen_string_literal: true

class Auth::ResourceOwnerFromCredentials
  include Interactor::Initializer

  initialize_with :request

  def run
    authenticated_user
  end

  private

  def authenticated_user
    user = User.find_for_authentication(email: username)
    user if user&.valid_password?(password)
  end

  def username
    request.params[:username]
  end

  def password
    request.params[:password]
  end
end
