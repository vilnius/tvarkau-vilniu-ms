RSpec.describe Photos::Create do
  describe '.for' do
    subject { described_class.for(params) }
    let(:params) { file_data }
    let(:file_data) do
      {
        file: file,
      }
    end
    let(:file) { '' }
    let(:upload_result) { true }

    before do
      expect(PhotoService).to receive(:upload_photo)
        .with(anything, file)
        .and_return(upload_result)
    end

    it 'returns uuid' do
      expect(subject).to be_present
    end

    context 'when upload fails' do
      let(:upload_result) { false }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
