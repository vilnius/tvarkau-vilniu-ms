# frozen_string_literal: true

class Auth::ResourceOwnerFromAssertion
  include Interactor::Initializer

  initialize_with :request

  def run
    user = fetch_user
    user if user&.active_for_authentication?
  end

  private

  def fetch_user
    case provider
    when 'google'
      Auth::Google::FetchUser.run(token)
    when 'facebook'
      Auth::Facebook::FetchUser.run(token)
    when 'viisp'
      Auth::Viisp::FetchUser.run(token)
    else
      raise(Doorkeeper::Errors::InvalidAuthorizationStrategy, "Unsupported provider #{provider}")
    end
  end

  def token
    request.params[:assertion]
  end

  def provider
    request.params[:provider]
  end
end
