RSpec.describe Auth::Google::FetchUserFromAssertion, '.run' do
  subject { described_class.run(token) }

  let(:token) { double(:google_token) }
  let(:google_profile) { build(:google_profile) }
  let(:user) { double }

  it 'loads profile and fetches user' do
    expect(Auth::Google::Profile).to receive(:from_token).with(token).and_return(google_profile)
    expect(Auth::Google::FetchUser).to receive(:run).with(google_profile).and_return(user)
    expect(subject).to be(user)
  end
end
