class Auth::Viisp::FetchUserFromOmniauth
  include Interactor::Initializer

  initialize_with :auth

  def run
    Auth::Viisp::FetchUser.run(identity)
  end

  private

  def identity
    auth.extra.raw_identity
  end
end
