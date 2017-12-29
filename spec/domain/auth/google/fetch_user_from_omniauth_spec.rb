RSpec.describe Auth::Google::FetchUserFromOmniauth, '.run' do
  subject { described_class.run(auth) }

  let(:auth) { build(:omniauth_auth) }
  let(:user) { double }

  it 'loads profile and fetches user' do
    expect(Auth::Google::FetchUser).to receive(:run).with(anything).and_return(user)
    expect(subject).to be(user)
  end
end
