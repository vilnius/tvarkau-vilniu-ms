RSpec.describe Auth::Google::FetchUser, '.run' do
  subject { described_class.run(token) }

  let(:token) { double }
  let(:google_profile) { build(:google_profile) }

  before do
    expect(Auth::Google::Profile).to receive(:from_token).with(token).and_return(google_profile)
  end

  context 'when token invalid' do
    let(:google_profile) { nil }
    it { is_expected.to be_nil }
  end

  context 'when user does not exist' do
    it 'creates user' do
      expect(subject).to be_instance_of(User)
      expect(subject).to be_persisted
    end
  end
end
