FactoryGirl.define do
  factory :report do
    ref_no { "ref-no-#{rand(0..10000)}" }
    description 'Description'
    address 'Gedimino pr 9.'
    lat '9.99'
    lng '9.99'
    report_date '2017-02-24 22:17:25'
    report_type { create(:report_type) }
    status Report::STATUS_REGISTERED

    trait :in_progress do
      status Report::STATUS_IN_PROGRESS
    end

    trait :postponed do
      status Report::STATUS_POSTPONED
    end

    trait :solved do
      status Report::STATUS_SOLVED
    end
  end
end
