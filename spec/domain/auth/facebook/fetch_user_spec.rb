RSpec.describe Auth::Facebook::FetchUser, '.run' do
  subject { described_class.run(profile) }

  let(:profile) do
    OpenStruct.new(
      email: 'test@email.com',
      first_name: 'Gediminas',
      last_name: 'Gediminaitis',
      id: '123',
    )
  end

  context 'when user does not exist' do
    it 'creates user' do
      expect(subject).to be_instance_of(User)
      expect(subject).to be_persisted
      expect(subject.facebook_id).to eq(profile.id)
      expect(subject.email).to eq(profile.email)
      expect(subject.name).to eq('Gediminas Gediminaitis')
    end
  end

  context 'when user exists' do
    let!(:user) { create(:user, email: profile.email) }

    it 'fetches user' do
      expect(subject).to eq(user)
    end
  end
end
