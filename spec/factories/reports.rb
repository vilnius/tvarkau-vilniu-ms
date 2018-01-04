FactoryBot.define do
  factory :report do
    user
    description 'Description'
    address 'Gedimino pr 9.'
    lat '9.99'
    lng '9.99'
    registered_at '2017-02-24 22:17:25'
    report_type { ReportType.find_by(id: 1) || create(:report_type) }
    status
    city_id { report_type.city_id }

    trait :in_progress do
      status { create(:status, :in_progress) }
    end

    trait :postponed do
      status { create(:status, :postponed) }
    end

    trait :solved do
      status { create(:status, :solved) }
    end

    trait :with_photos do
      report_photos { [build(:report_photo)] }
    end
  end
end
