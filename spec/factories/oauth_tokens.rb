FactoryBot.define do
  factory :oauth_token, class: 'Doorkeeper::AccessToken' do
    transient do
      user nil
    end

    application { create(:oauth_application) }
    scopes 'user'
    resource_owner_id { user&.id }
  end
end
