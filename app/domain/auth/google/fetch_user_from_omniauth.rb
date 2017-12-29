class Auth::Google::FetchUserFromOmniauth
  include Interactor::Initializer

  initialize_with :auth

  def run
    Auth::Google::FetchUser.run(profile)
  end

  private

  def profile
    auth.info.merge(id: auth.uid)
  end
end
