module Auth::ValidateProvider
  PATTERN = /\A[a-z0-9]+\z/i

  module_function

  def run(provider)
    return true if provider =~ PATTERN

    raise(Doorkeeper::Errors::InvalidAuthorizationStrategy, "Unsupported provider #{provider}")
  end
end
