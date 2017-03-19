RSpec.describe Report do

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:report_type_id) }
  it { is_expected.to validate_presence_of(:lat) }
  it { is_expected.to validate_numericality_of(:lat).is_greater_than_or_equal_to(-90) }
  it { is_expected.to validate_numericality_of(:lat).is_less_than_or_equal_to(90) }
  it { is_expected.to validate_presence_of(:lng) }
  it { is_expected.to validate_numericality_of(:lng).is_greater_than_or_equal_to(-180) }
  it { is_expected.to validate_numericality_of(:lng).is_less_than_or_equal_to(180) }

  describe 'report type validations' do
    let(:report_type_id) { -1 }
    subject(:report) { build(:report, report_type_id: report_type_id) }

    context 'with existing report' do
      let(:report_type) { create(:report_type) }
      let(:report_type_id) { report_type.id }

      it 'should have no errors on report type' do
        report.save
        expect(report.errors.keys).not_to include(:report_type)
      end
    end
  end

  describe 'report validations' do
    let(:report_type_id) { -1 }
    subject(:report) { build(:report, report_type_id: report_type_id) }

    context 'with plate validation' do
      let(:report_type) { create(:report_type, :validate_plate) }
      let(:report_type_id) { report_type.id }

      it 'should have plate validation error' do
        report.save
        expect(report.errors.keys).to include(:plate_number)
      end
    end
  end
end
