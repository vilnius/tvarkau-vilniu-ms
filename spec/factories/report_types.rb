FactoryGirl.define do
  factory :report_type do
    title 'Aplinkos tvarkymas'

    trait :validate_plate do
      validate_plate true
    end
  end
end
