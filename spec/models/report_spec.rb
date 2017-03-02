RSpec.describe Report do
  describe 'description validations' do
    let(:description) { 'this is a valid description' }
    subject(:report) { build(:report, description: description) }

    it 'should have 1 error on description' do
      report.description = nil
      report.save
      expect(report).to have(1).error_on(:description)
    end
  end

  describe 'address validations' do
    let(:address) { 'Gedimino pr. 9' }
    subject(:report) { build(:report, address: address) }

    it 'should have 1 error on address' do
      report.address = nil
      report.save
      expect(report).to have(1).error_on(:address)
    end
  end

  describe 'latitude longitude validations' do
    let(:lat) { '53.2123' }
    let(:lng) { '23.2131'}
    subject(:report) { build(:report, lat: lat, lng: lng) }

    it 'should have errors on lat and lng' do
      report.lng = nil
      report.lat = nil
      report.save
      expect(report).to have(1).error_on(:lat)
      expect(report).to have(1).error_on(:lng)
    end
  end

  describe 'report type validations' do
    let(:report_type_id) { -1 }
    subject(:report) { build(:report, report_type_id: report_type_id) }

    it 'should have errors on report type' do
      report.save
      expect(report.errors.keys).to include(:report_type)
    end

    describe 'with existing report' do
      let(:report_type) { create(:report_type) }
      let(:report_type_id) { report_type.id }

      it 'should have no errors on report type' do
        report.save
        expect(report.errors.keys).not_to include(:report_type)
      end
    end
  end
end
