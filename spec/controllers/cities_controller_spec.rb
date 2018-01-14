RSpec.describe CitiesController do
  describe '#index' do
    subject { api_get :index, params: params }

    let(:params) { {} }
    let!(:city) { create(:city) }

    it 'returns cities' do
      expect(subject).to have_http_status(:ok)
      expect(response_json['cities'].first).to include('id' => city.id)
    end
  end
end
