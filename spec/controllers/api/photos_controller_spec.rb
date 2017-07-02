RSpec.describe Api::PhotosController do
  before { api_auth_token }

  describe '#for' do
    subject { api_post :create, photo }
    let(:photo) do
      {
        photo: {
          file: file,
        },
      }
    end
    let(:file) { '' }
    let(:uuid) { 'uuid' }

    before do
      expect(Photos::Create).to receive(:for).with(file: file).and_return(uuid)
    end

    it 'returns uuid' do
      expect(subject).to have_http_status :ok
      expect(response_json['photo_uuid']).to eq(uuid)
    end

    context 'when upload failed' do
      let(:uuid) { nil }

      it 'returns error' do
        expect(subject).to have_http_status :bad_request
        expect(response_json['message']).to eq(I18n.t('error.uploading_photo'))
      end
    end
  end
end