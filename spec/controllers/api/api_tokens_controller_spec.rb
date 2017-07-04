RSpec.describe Api::ApiTokensController do
  describe '#create' do
    subject { api_post :create }

    it 'returns auth token' do
      expect(subject).to have_http_status(:ok)
      expect(response_json['token']).to be_present
    end
  end
end
