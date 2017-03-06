RSpec.describe Reports::Create do
  describe '.for' do
    subject { described_class.for(Report.new, params) }
    let(:params) { {} }

    it 'returns report with validation errors' do
      expect(subject.errors).to be_present
    end
  end
end