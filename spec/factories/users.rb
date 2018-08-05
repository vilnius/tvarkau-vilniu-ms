FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@vilnius.lt" }
    password 'test123'
    password_confirmation { password }
    confirmed_at { Time.zone.now }

    association :city
  end
end
