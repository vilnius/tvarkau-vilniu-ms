RSpec.describe Auth::Viisp::FetchUser, '.run' do
  subject { described_class.run(identity) }

  let(:identity) do
    {
      'authentication_provider' => 'auth.lt.bank',
      'attributes' => {
        'lt-personal-code' => '10000000001'
      },
      'user_information' => {
        'firstName' => 'VARDENIS',
        'lastName' => 'PAVARDENIS',
        'companyName' => nil,
        'phoneNumber' => '123',
        'email' => 'vardenis@vilnius.lt',
        'address' => 'Gedimino 1',
      },
    }
  end

  context 'and user does not exist' do
    it 'creates user' do
      expect(subject).to be_instance_of(User)
      expect(subject).to be_persisted
      expect(subject.name).to eq('VARDENIS PAVARDENIS')
      expect(subject.email).to be_nil
      expect(subject.unconfirmed_email).to eq('vardenis@vilnius.lt')
      expect(subject.phone).to eq('123')
      expect(subject.address).to eq('Gedimino 1')
      expect(subject.personal_code).to eq(10000000001)
    end
  end

  context 'and user exists' do
    let!(:user) { create(:user, personal_code: identity['attributes']['lt-personal-code']) }

    it 'fetches user' do
      expect(subject).to eq(user)
    end
  end
end
