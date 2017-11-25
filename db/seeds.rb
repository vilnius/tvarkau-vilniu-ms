# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Doorkeeper::Application.create!(
  name: 'Android',
  uid: 'android',
  redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
  scopes: 'user',
)
