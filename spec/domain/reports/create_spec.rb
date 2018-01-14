# frozen_string_literal: true

RSpec.describe Reports::Create, '.run' do
  subject { described_class.run(user, params) }

  let(:user) { create(:user) }
  let(:status) { create(:status) }
  let(:report_type) { create(:report_type) }

  let(:params) do
    {
      report_type_id: report_type.id,
      status_id: status.id,
      description: 'Test report',
      address: 'Test address',
      lat: 19,
      lng: 20,
      # license_plate_no: 'ABC123',
      registered_at: Time.zone.parse('2017-12-01'),
    }
  end

  it 'creates report' do
    expect(subject).to be_persisted
    expect(subject.user).to eq(user)
    expect(subject.report_type).to eq(report_type)
    expect(subject.status).to eq(status)
    expect(subject.description).to eq(params[:description])
    expect(subject.address).to eq(params[:address])
    expect(subject.lat).to eq(params[:lat])
    expect(subject.lng).to eq(params[:lng])
    # expect(subject.license_plate_no).to eq(params[:license_plate_no])
    expect(subject.registered_at).to eq(params[:registered_at])
  end

  context 'when report is invalid' do
    let(:params) { {} }

    it 'returns report with validation errors' do
      expect(subject.errors).to be_present
    end
  end
end
