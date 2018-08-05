FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    sequence(:name) { |n| "OAuth Application #{n}" }
    sequence(:uid) { |n| "app-#{n}" }
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
    scopes 'user'
    confidential false
  end
end
