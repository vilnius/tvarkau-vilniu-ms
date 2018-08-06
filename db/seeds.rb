# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

unless Doorkeeper::Application.exists?(uid: 'android')
  Doorkeeper::Application.create!(
    name: 'Android',
    uid: 'android',
    redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
    scopes: 'public user',
    confidential: false,
  )
end

unless Doorkeeper::Application.exists?(uid: 'ios')
  Doorkeeper::Application.create!(
    name: 'iOS',
    uid: 'ios',
    redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
    scopes: 'public user',
    confidential: false,
  )
end

unless Doorkeeper::Application.exists?(uid: 'web')
  redirect_uri = ENV['WEB_REDIRECT_URI'] || 'https://tvarkaumiesta.lt/auth/callback'

  Doorkeeper::Application.create!(
    name: 'Web',
    uid: 'web',
    secret: Secret['WEB_OAUTH2_SECRET'],
    redirect_uri: redirect_uri,
    scopes: 'public user',
    confidential: false,
  )
end

unless City.exists?(code: 'vilnius')
  City.create!(
    name: 'Vilnius',
    code: 'vilnius',
    lat: '54.687157',
    lng: '25.279652',
    active: true,
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
