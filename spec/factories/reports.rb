FactoryBot.define do
  factory :report do
    user
    description 'Description'
    address 'Gedimino pr 9.'
    lat '9.99'
    lng '9.99'
    registered_at '2017-02-24 22:17:25'
    report_type { ReportType.find_by(id: 1) || create(:report_type) }
    status { StatusType.find_by(status: 'Registruota') || create(:status_type) }
    city_id { report_type.city_id }

    trait :in_progress do
      status { StatusType.find_by(status: 'Vykdoma') || create(:status_type, :in_progress) }
    end

    trait :postponed do
      status { StatusType.find_by(status: 'Atidėta') || create(:status_type, :postponed) }
    end

    trait :solved do
      status { StatusType.find_by(status: 'Išnagrinėta') || create(:status_type, :solved) }
    end
  end
end
