FactoryBot.define do
  factory :report_type do
    transient do
      main_cfg { MainCfg.find_by(id: 1) || create(:main_cfg) }
    end

    title 'Aplinkos tvarkymas'
    short_label 'Aplinkos tvarkymas'
    city_id { main_cfg.id }

    factory :parking_violation_report_type do
      requires_photos 2
      requires_license_plate_no true
      requires_registered_at true
      requires_viisp_auth true
    end
  end
end
