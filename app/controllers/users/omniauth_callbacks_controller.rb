class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    sign_in_with_omniauth
  end

  def facebook
    sign_in_with_omniauth
  end

  def failure
    redirect_to root_path
  end

  private

  def sign_in_with_omniauth
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user, event: :authentication
  end
end
