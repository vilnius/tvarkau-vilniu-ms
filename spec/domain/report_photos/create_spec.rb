# frozen_string_literal: true

RSpec.describe ReportPhotos::Create, '.run' do
  subject { described_class.run(uploaded_file) }

  let(:uploaded_file) { Rack::Test::UploadedFile.new(file, 'image/jpeg') }
  let(:file) { Rails.root.join('spec/fixtures/seal.jpg') }

  it 'creates photo' do
    expect(subject.uuid).to be_present
    expect(subject.photo.url).to be_present
  end
end
