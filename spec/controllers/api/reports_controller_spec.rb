RSpec.describe Api::ReportsController do
  describe '#show' do
    subject { api_get :show, params: params }

    let(:report) { create(:report) }
    let(:params) { { id: report.id } }

    it 'returns report' do
      expect(subject).to be_success

      expect(response_json).to include(
        'ref_no' => instance_of(String),
      )
    end
  end

  describe '#index' do
    subject { api_get :index, params: params }

    let(:params) { {} }

    before do
      create(:report)
      create(:report)
    end

    it 'returns reports' do
      expect(subject).to have_http_status(:ok)
      expect(response_json).to include('entries')
    end
  end

  describe '#create' do
    subject { api_post :create, params: params }

    let(:params) do
      {
        report: {
          description: 'Description'
        }
      }
    end

    let(:report) { create(:report) }

    before do
      allow(::Reports::Create).to receive(:for) { report }
    end

    it 'returns reports' do
      expect(subject).to be_success
      expect(response_json).to include(
        'ref_no' => instance_of(String),
      )
    end

    context 'when report has validation errors' do
      let(:report) { Report.new.tap(&:save) }

      it 'returns errors' do
        expect(subject).to have_http_status(:bad_request)
        expect(response_json).to include('errors')
      end
    end
  end
end
