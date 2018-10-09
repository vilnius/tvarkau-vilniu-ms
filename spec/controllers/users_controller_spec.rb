# frozen_string_literal: true

RSpec.describe UsersController do
  describe '#show' do
    subject { api_get :show }

    it 'returns current user' do
      expect(subject).to be_successful

      expect(response_json['user']).to include(
        'id' => user.id,
        'email' => user.email,
        'name' => user.name,
        'guest' => user.guest,
        'created_at' => user.created_at,
      )
    end
  end
end
