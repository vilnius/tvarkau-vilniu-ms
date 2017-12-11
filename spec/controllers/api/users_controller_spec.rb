# frozen_string_literal: true

RSpec.describe Api::UsersController do
  describe '#show' do
    subject { api_get :show }

    it 'returns current user' do
      expect(subject).to be_success

      expect(response_json).to include(
        'id' => user.id,
        'email' => user.email,
        'created_at' => user.created_at,
      )
    end
  end
end
