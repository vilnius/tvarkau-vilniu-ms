FactoryGirl.define do
  factory :report do
    ref_no { "ref-no-#{rand(0..10000)}" }
    description 'Description'
    address 'Gedimino pr 9.'
    lat '9.99'
    lng '9.99'
    report_date '2017-02-24 22:17:25'
    report_type { create(:report_type) }
  end
end
