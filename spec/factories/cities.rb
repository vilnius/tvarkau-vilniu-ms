FactoryBot.define do
  factory :city do
    initialize_with { City.find_by(code: code) || new(attributes) }

    code 'vilnius'
    name 'Vilnius'
    lat '54.687157'
    lng '25.279652'
    active true
  end
end
