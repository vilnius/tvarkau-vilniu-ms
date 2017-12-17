# frozen_string_literal: true

module Users::CreateGuest
  module_function

  def run
    User.new do |user|
      user.email = [SecureRandom.uuid, APP_CONFIG['guest_email_domain']].join('@')
      user.password = SecureRandom.uuid
      user.password_confirmation = user.password
      user.skip_confirmation!
      user.guest = true
      user.save!
    end
  end
end
