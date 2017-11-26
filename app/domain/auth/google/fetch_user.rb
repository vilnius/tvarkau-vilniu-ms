class Auth::Google::FetchUser
  include Interactor::Initializer

  initialize_with :token

  def run
    return unless profile

    existing_user || create_user
  end

  private

  def profile
    @profile ||= Auth::Google::Profile.from_token(token)
  end

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
end
