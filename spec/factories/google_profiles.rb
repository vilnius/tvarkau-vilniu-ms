FactoryBot.define do
  factory :google_profile, class: 'OpenStruct' do
    sequence(:id)
    sequence(:email) { |n| "gediminas#{n}@vilnius.lt" }
    given_name 'Gediminas'
    family_name 'Gediminaitis'
    picture ''
    locale ''
  end
end
