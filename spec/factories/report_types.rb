FactoryGirl.define do
  factory :report_type do
    transient do
      main_cfg { MainCfg.find_by(id: 1) || create(:main_cfg) }
    end

    title 'Aplinkos tvarkymas'
    short_label 'Aplinkos tvarkymas'
    city_id { main_cfg.id }
  end
end
