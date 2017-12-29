class Auth::Viisp::FetchUser
  include Interactor::Initializer

  initialize_with :identity

  def run
    return unless identity

    existing_user || create_user
  end

  private

  def existing_user
    User.find_by(personal_code: personal_code)
  end

  def create_user
    User.new do |u|
      u.personal_code = personal_code
      u.name = name
      u.phone = identity['user_information']['phoneNumber']
      u.address = identity['user_information']['address']
      u.unconfirmed_email = identity['user_information']['email']
      u.password = Devise.friendly_token
      u.password_confirmation = u.password
      u.skip_confirmation!
      u.save!
    end
  end

  def personal_code
    identity['attributes']['lt-personal-code']
  end

  def email
    return unless identity['user_information']['email'].present?
    identity['user_information']['email'].downcase
  end

  def name
    [identity['user_information']['firstName'], identity['user_information']['lastName']].join(' ')
  end
end
