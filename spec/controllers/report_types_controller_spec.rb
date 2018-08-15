RSpec.describe ReportTypesController do
  describe '#index' do
    subject { api_get :index }

    let!(:report_type) { create(:report_type, city: user.city) }
    let(:user) { create(:user) }

    it 'returns list' do
      expect(subject).to be_successful
      expect(response_json['report_types']).not_to be_empty
    end

    context 'when user has no city' do
      let(:user) { create(:user, city: nil) }
      let!(:report_type) { create(:report_type) }

      before { request.headers['X-City-ID'] = report_type.city.id }

      it { is_expected.to be_successful }
    end
  end
end
