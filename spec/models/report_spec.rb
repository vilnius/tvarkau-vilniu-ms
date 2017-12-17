RSpec.describe Report do
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:report_type) }
  it { is_expected.to validate_presence_of(:lat) }
  it { is_expected.to validate_numericality_of(:lat).is_greater_than_or_equal_to(-90) }
  it { is_expected.to validate_numericality_of(:lat).is_less_than_or_equal_to(90) }
  it { is_expected.to validate_presence_of(:lng) }
  it { is_expected.to validate_numericality_of(:lng).is_greater_than_or_equal_to(-180) }
  it { is_expected.to validate_numericality_of(:lng).is_less_than_or_equal_to(180) }
  it { is_expected.not_to validate_presence_of(:license_plate_no) }
  it { is_expected.not_to validate_presence_of(:registered_at) }

  describe 'validations by report type' do
    subject { build(:report, report_type: report_type) }

    let(:report_type) { build(:parking_violation_report_type) }

    it { is_expected.to validate_presence_of(:license_plate_no) }
    it { is_expected.to validate_presence_of(:registered_at) }
  end
end
