# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

unless Doorkeeper::Application.exists?(uid: 'android')
  Doorkeeper::Application.create!(
    name: 'Android',
    uid: 'android',
    redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
    scopes: 'user',
  )
end

unless Rails.env.production?
  unless User.exists?(email: 'gediminas@vilnius.lt')
    user = User.new(
      email: 'gediminas@vilnius.lt',
      password: 'test123',
      password_confirmation: 'test123',
    )

    user.skip_confirmation!
    user.save!
  end
end
