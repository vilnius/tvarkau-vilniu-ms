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
    User.find_by('facebook_id=? OR email=?', profile.id, email)
  end

  def create_user
    User.new do |u|
      u.facebook_id = profile.id
      u.name = name
      u.email = email
      u.password = Devise.friendly_token
      u.password_confirmation = u.password
      u.skip_confirmation!
      u.save!
    end
  end

  def name
    [profile.first_name, profile.last_name].reject(&:blank?).join(' ')
  end

  def email
    raise('Facebook email is missing') unless profile.email.present?
    profile.email.downcase
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
