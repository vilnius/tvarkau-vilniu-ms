FactoryBot.define do
  factory :status do
    initialize_with { Status.find_by(title: title) || new(attributes) }

    title 'Registruota'
    color '0f76bb'
    avilys_status 'registered'
    active 1

    trait :in_progress do
      title 'Vykdoma'
      avilys_status 'inExecution'
    end

    trait :postponed do
      title 'Atidėta'
    end

    trait :solved do
      title 'Išnagrinėta'
      avilys_status 'completed'
    end
  end
end
