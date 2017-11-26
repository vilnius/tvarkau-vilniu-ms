# frozen_string_literal: true

class Auth::ResourceOwnerFromAssertion
  include Interactor::Initializer

  initialize_with :request

  def run
    case provider
    when 'google'
      Auth::Google::FetchUser.run(token)
    else
      raise(Doorkeeper::Errors::InvalidAuthorizationStrategy, "Unsupported provider #{provider}")
    end
  end

  private

  def token
    request.params[:assertion]
  end

  def provider
    request.params[:provider]
  end
end
