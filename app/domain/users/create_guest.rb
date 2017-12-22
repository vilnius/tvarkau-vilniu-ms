# frozen_string_literal: true

module Users::CreateGuest
  module_function

  def run
    User.new do |user|
      user.password = SecureRandom.uuid
      user.password_confirmation = user.password
      user.skip_confirmation!
      user.guest = true
      user.save!
    end
  end
end
