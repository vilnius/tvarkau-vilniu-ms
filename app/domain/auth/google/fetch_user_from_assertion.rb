class Auth::Google::FetchUserFromAssertion
  include Interactor::Initializer

  initialize_with :token

  def run
    Auth::Google::FetchUser.run(profile)
  end

  private

  def profile
    Auth::Google::Profile.from_token(token)
  end
end
