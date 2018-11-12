RSpec.describe Reports::Filter, '.for' do
  subject { described_class.for(params) }

  let(:type_1) { create(:report_type, title: 'KET') }
  let(:type_2) { create(:report_type, title: 'Aplinka') }
  let(:registered) { create(:report_status) }
  let(:in_progress) { create(:report_status, :in_progress) }
  let(:postponed) { create(:report_status, :postponed) }
  let!(:report_1) { create(:report, report_status: registered, lat: '56.68', lng: '25.27') }
  let!(:report_2) { create(:report, report_status: in_progress, report_type: type_1) }
  let!(:report_3) { create(:report, report_status: postponed, report_type: type_2) }
  let(:params) do
    {
      per_page: 2,
    }
  end

  it 'returns limited result count' do
    expect(subject.size).to eq 2
  end

  context 'with different statuses' do
    let(:params) do
      {
        status: [registered.id, in_progress.id],
      }
    end

    it 'returns filtered reports' do
      expect(subject).to include report_1
      expect(subject).to include report_2
    end
  end

  context 'with different types' do
    let(:params) do
      {
        type: [type_1.id, type_2.id],
      }
    end

    it 'returns filtered reports' do
      expect(subject).to include(report_2, report_3)
    end
  end

  context 'with mixed params' do
    let!(:report_4) { create(:report, :postponed, report_type: type_1) }
    let(:params) do
      {
        type: [type_1.id],
        status: [postponed.id],
      }
    end

    it 'returns filtered reports' do
      expect(subject).to contain_exactly(report_4)
    end
  end

  context 'with user filter' do
    let(:params) do
      { user_id: report_1.user_id }
    end

    it { is_expected.to contain_exactly(report_1) }
  end

  context 'with coords filter' do
    let(:params) do
      { lat_from: 56.1, lat_to: 57.1, lng_from: 25.1, lng_to: 26.1 }
    end

    it { is_expected.to contain_exactly(report_1) }
  end
end
