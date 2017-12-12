RSpec.describe Reports::Create do
  describe '.for' do
    subject { described_class.for(user.reports.new, params) }

    let(:params) { {} }
    let(:user) { create(:user) }

    it 'returns report with validation errors' do
      expect(subject.errors).to be_present
    end
  end
end
