RSpec.describe Api::ReportsController do
  describe '#show' do
    subject { api_get :show, params }
    let(:report) { create(:report) }
    let(:params) { { :id => report.id } }

    it 'returns report' do
      expect(subject).to have_http_status(:ok)
      expect(response_json).to include('report')
      expect(response_json['report']['ref_no']).to eq 'ref-no'
    end
  end

  describe '#index' do
    subject { api_get :index, params }
    let(:params) { {} }

    it 'returns reports' do
      expect(subject).to have_http_status(:ok)
      expect(response_json).to include('entries')
    end
  end

  describe '#create' do
  end
end
