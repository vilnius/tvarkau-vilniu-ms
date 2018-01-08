RSpec.describe ReportPhotosController do
  describe '#create' do
    subject { api_post :create, params: params }

    let(:params) do
      {
        report_photo: { file: uploaded_file },
      }
    end

    let(:uploaded_file) { Rack::Test::UploadedFile.new(file, 'image/jpeg') }
    let(:file) { Rails.root.join('spec/fixtures/seal.jpg') }

    it 'returns uuid' do
      expect(subject).to be_success
      expect(response_json['uuid']).to be_present
    end

    context 'when upload failed' do
      let(:uploaded_file) { Rack::Test::UploadedFile.new(file, 'text/plain') }

      it 'returns error' do
        expect(subject).not_to be_success
        expect(response_json['message']).to eq(I18n.t('error.uploading_photo'))
      end
    end
  end
end
