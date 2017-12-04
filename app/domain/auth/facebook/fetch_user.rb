class Auth::Facebook::FetchUser
  include Interactor::Initializer

  USER_FIELDS = %w[email first_name last_name]

  initialize_with :token

  def run
    return unless profile

    existing_user || create_user
  end

  private

  def existing_user
    User.find_by(email: profile.email)
  end

  def create_user
    User.new do |u|
      u.email = profile.email
      u.password = Devise.friendly_token
      u.password_confirmation = u.password
      u.skip_confirmation!
      u.save!
    end
  end

  def profile
    @profile ||= OpenStruct.new(
      graph.get_object('me', fields: USER_FIELDS)
    )
  rescue Koala::Facebook::AuthenticationError => e
  end

  def graph
    @graph ||= Koala::Facebook::API.new(token)
  end
end
