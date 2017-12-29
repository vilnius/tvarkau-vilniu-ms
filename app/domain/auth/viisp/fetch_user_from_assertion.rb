class Auth::Viisp::FetchUserFromAssertion
  include Interactor::Initializer

  initialize_with :token

  def run
    Auth::Viisp::FetchUser.run(identity)
  end

  private

  def identity
    VIISP::Auth.identity(ticket: token)
  rescue VIISP::Auth::RequestError => e
    Rails.logger.error("VIISP request error #{e.message}")
    nil
  end
end
