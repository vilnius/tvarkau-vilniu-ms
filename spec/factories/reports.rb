FactoryGirl.define do
  factory :report do
    description 'Description'
    address 'Gedimino pr 9.'
    lat '9.99'
    lng '9.99'
    report_date '2017-02-24 22:17:25'
    report_type { ReportType.find_by(id: 1) || create(:report_type) }
    status_type { StatusType.find_by(status: 'Registruota') || create(:status_type) }
    CITY_ID { report_type.city_id }

    trait :in_progress do
      status_type { StatusType.find_by(status: 'Vykdoma') || create(:status_type, :in_progress) }
    end

    trait :postponed do
      status_type { StatusType.find_by(status: 'Atidėta') || create(:status_type, :postponed) }
    end

    trait :solved do
      status_type { StatusType.find_by(status: 'Išnagrinėta') || create(:status_type, :solved) }
    end
  end
end
