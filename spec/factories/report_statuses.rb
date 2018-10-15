FactoryBot.define do
  factory :report_status do
    initialize_with { ReportStatus.find_by(title: title) || new(attributes) }

    active 1
    registered

    trait :registered do
      title 'Registruota'
      color '0f76bb'
      avilys_status 'registered'
    end

    trait :in_progress do
      title 'Nagrinėjama'
      color 'f0adėe'
      avilys_status 'inExecution'
    end

    trait :completed do
      title 'Išnagrinėta'
      color '39b54a'
      avilys_status 'completed'
    end

    trait :postponed do
      title 'Atidėta'
      color '8f8e94'
      active 0
      avilys_status ''
    end

    trait :forwarded do
      title 'Perduota'
      color 'ff9600'
      active 0
      avilys_status ''
    end
  end
end
