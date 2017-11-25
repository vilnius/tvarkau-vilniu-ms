FactoryBot.define do
  factory :api_auth_token do
    token 'token'
    last_used DateTime.current
  end
end
