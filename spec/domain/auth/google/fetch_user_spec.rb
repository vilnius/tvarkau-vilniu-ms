RSpec.describe Auth::Google::FetchUser, '.run' do
  subject { described_class.run(google_profile) }

  let(:google_profile) { build(:google_profile) }

  context 'when token invalid' do
    let(:google_profile) { nil }
    it { is_expected.to be_nil }
  end

  context 'when user does not exist' do
    it 'creates user' do
      expect(subject).to be_instance_of(User)
      expect(subject).to be_persisted
      expect(subject.google_id).to eq(google_profile.id.to_s)
      expect(subject.email).to eq(google_profile.email)
      expect(subject.name).to be_present
    end
  end

  context 'when user exists' do
    let!(:user) { create(:user, email: google_profile.email) }

    it 'fetches user' do
      expect(subject).to eq(user)
    end
  end
end
