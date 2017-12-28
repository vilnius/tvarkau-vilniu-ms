class Auth::Facebook::FetchUserFromAssertion
  include Interactor::Initializer

  initialize_with :token

  USER_FIELDS = %w[email name first_name last_name].freeze

  def run
    Auth::Facebook::FetchUser.run(profile)
  end

  private

  def profile
    OpenStruct.new(
      graph.get_object('me', fields: USER_FIELDS)
    )
  rescue Koala::Facebook::AuthenticationError => e
  end

  def graph
    @graph ||= Koala::Facebook::API.new(token)
  end
end
