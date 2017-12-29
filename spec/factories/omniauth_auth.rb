FactoryBot.define do
  factory :omniauth_auth, class: 'OmniAuth::AuthHash' do
    sequence(:uid)
    info { OmniAuth::KeyStore.new(email: 'gediminas1@vilnius.lt') }
  end
end
