class Auth::Facebook::FetchUserFromOmniauth
  include Interactor::Initializer

  initialize_with :auth

  def run
    Auth::Facebook::FetchUser.run(profile)
  end

  private

  def profile
    auth.info.merge(id: auth.uid)
  end
end
