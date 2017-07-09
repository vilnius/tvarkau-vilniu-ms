RSpec.describe Reports::Filter do
  describe '.for' do
    subject { described_class.for(params) }

    let(:type_1) { create(:report_type, title: 'KET') }
    let(:type_2) { create(:report_type, title: 'Aplinka') }
    let!(:report_1) { create(:report) }
    let!(:report_2) { create(:report, :in_progress, report_type_id: type_1.id) }
    let!(:report_3) { create(:report, :postponed, report_type_id: type_2.id) }
    let(:params) do
      {
        limit: 2
      }
    end

    it 'returns limited result count' do
      expect(subject.size).to eq 2
    end

    context 'with different statuses' do
      let(:params) do
        {
          status: [ Report::STATUS_REGISTERED, Report::STATUS_IN_PROGRESS ]
        }
      end

      it 'returns filtered reports' do
        expect(subject).to include(report_1, report_2)
      end
    end

    context 'with different types' do
      let(:params) do
        {
          type: [ type_1.id, type_2.id ]
        }
      end

      it 'returns filtered reports' do
        expect(subject).to include(report_2, report_3)
      end
    end

    context 'with mixed params' do
      let!(:report_4) { create(:report, :postponed, report_type_id: type_1.id) }
      let(:params) do
        {
          type: [ type_1.id ],
          status: [ Report::STATUS_POSTPONED ],
        }
      end

      it 'returns filtered reports' do
        expect(subject).to contain_exactly(report_4)
      end
    end
  end
end
