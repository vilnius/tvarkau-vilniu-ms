FactoryBot.define do
  factory :report_type do
    city
    title 'Aplinkos tvarkymas'
    short_label 'Aplinkos tvarkymas'

    factory :parking_violation_report_type do
      requires_photos 2
      requires_license_plate_no true
      requires_registered_at true
      requires_viisp_auth true
    end
  end
end
