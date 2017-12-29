class Auth::Google::FetchUser
  include Interactor::Initializer

  initialize_with :profile

  def run
    return unless profile

    existing_user || create_user
  end

  private

  def existing_user
    User.find_by('google_id=? OR email=?', profile.id, email)
  end

  def create_user
    User.new do |u|
      u.google_id = profile.id
      u.name = name
      u.email = email
      u.password = Devise.friendly_token
      u.password_confirmation = u.password
      u.skip_confirmation!
      u.save!
    end
  end

  def name
    profile.name.presence || build_name
  end

  def build_name
    [profile.given_name, profile.family_name].reject(&:blank?).join(' ')
  end

  def email
    raise('Google email is missing') unless profile.email.present?
    profile.email.downcase
  end
end
