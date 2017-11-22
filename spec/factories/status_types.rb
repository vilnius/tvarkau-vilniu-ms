FactoryGirl.define do
  factory :status_type do
    status 'Registruota'
    color '0f76bb'
    avilys_status 'registered'
    active 1
  end

  trait :in_progress do
    status 'Vykdoma'
    avilys_status 'inExecution'
  end

  trait :postponed do
    status 'Atidėta'
  end

  trait :solved do
    status 'Išnagrinėta'
    avilys_status 'completed'
  end
end
