FactoryBot.define do
  factory :report do
    user
    description 'Description'
    address 'Gedimino pr 9.'
    lat '9.99'
    lng '9.99'
    registered_at '2017-02-24 22:17:25'
    report_type { ReportType.find_by(id: 1) || create(:report_type, id: 1) }
    city_id { report_type.city_id }

    association :report_status

    trait :in_progress do
      report_status { create(:report_status, :in_progress) }
    end

    trait :postponed do
      report_status { create(:report_status, :postponed) }
    end

    trait :solved do
      report_status { create(:report_status, :solved) }
    end

    trait :with_photos do
      report_photos { [build(:report_photo)] }
    end
  end
end
