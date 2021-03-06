# frozen_string_literal: true

class Auth::ResourceOwnerFromAssertion
  include Interactor::Initializer

  initialize_with :request

  def run
    Auth::ValidateProvider.run(provider)

    user = fetch_user
    user if user&.active_for_authentication?
  end

  private

  def fetch_user
    adapter.run(assertion)
  end

  def adapter
    "Auth::#{provider.capitalize}::FetchUserFromAssertion".constantize
  rescue NameError
    raise(Doorkeeper::Errors::InvalidAuthorizationStrategy, "Unsupported provider #{provider}")
  end

  def assertion
    request.params[:assertion]
  end

  def provider
    request.params[:provider]
  end
end
