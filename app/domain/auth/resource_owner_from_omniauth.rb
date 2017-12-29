# frozen_string_literal: true

class Auth::ResourceOwnerFromOmniauth
  include Interactor::Initializer

  initialize_with :auth

  PROVIDER_MAP = {
    'google_oauth2' => 'google',
  }.freeze

  def run
    Auth::ValidateProvider.run(provider)

    user = fetch_user
    user if user&.active_for_authentication?
  end

  private

  def fetch_user
    adapter.run(auth)
  end

  def adapter
    "Auth::#{provider.capitalize}::FetchUserFromOmniauth".constantize
  rescue NameError
    raise(Doorkeeper::Errors::InvalidAuthorizationStrategy, "Unsupported provider #{provider}")
  end

  def provider
    PROVIDER_MAP[auth.provider] || auth.provider
  end
end
