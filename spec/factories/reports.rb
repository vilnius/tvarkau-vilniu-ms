FactoryGirl.define do
  factory :report do
    description 'Description'
    address 'Gedimino pr 9.'
    lat '9.99'
    lng '9.99'
    report_date '2017-02-24 22:17:25'
    report_type_id { create(:report_type).id }
    status_id Report::STATUS_REGISTERED

    trait :in_progress do
      status_id Report::STATUS_IN_PROGRESS
    end

    trait :postponed do
      status_id Report::STATUS_POSTPONED
    end

    trait :solved do
      status_id Report::STATUS_RESOLVED
    end
  end
end
