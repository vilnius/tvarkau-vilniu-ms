# frozen_string_literal: true

RSpec.describe Api::UsersController do
  describe '#show' do
    subject { api_get :show }

    it 'returns current user' do
      expect(subject).to be_success

      expect(response_json).to include(
        'data' => {
          'id' => user.id.to_s,
          'type' => 'users',
          'attributes' => {
            'email' => user.email,
            'created-at' => user.created_at,
          },
        }
      )
    end
  end
end
