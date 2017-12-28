class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :reports

  def email_required?
    !guest? && !personal_code?
  end

  def self.find_for_authentication(tainted_conditions)
    find_first_by_auth_conditions(tainted_conditions, blacklisted: false)
  end

  def active_for_authentication?
    super && !blacklisted?
  end

  def self.from_omniauth(auth)
    case auth.provider
    when 'google_oauth2'
      where(email: auth.info.email).first_or_create do |user|
        user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
      end
    when 'facebook'
      where(email: auth.info.email).first_or_create do |user|
        user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
      end
    end
  end
end
