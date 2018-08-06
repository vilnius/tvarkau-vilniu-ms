RSpec.describe ReportStatusesController do
  describe '#index' do
    subject { api_get :index }

    let!(:report_status) { create(:report_status) }

    it 'returns list' do
      expect(subject).to be_successful
      expect(response_json['report_statuses']).not_to be_empty
    end
  end
end
