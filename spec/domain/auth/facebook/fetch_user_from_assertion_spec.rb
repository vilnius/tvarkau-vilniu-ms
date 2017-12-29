RSpec.describe Auth::Facebook::FetchUserFromAssertion, '.run' do
  subject { described_class.run(token) }

  let(:token) { double(:token) }
  let(:user) { double }

  let(:graph_response) do
    {
      email: 'test@email.com',
      first_name: 'Gediminas',
      last_name: 'Gediminaitis',
      id: '123',
    }
  end

  let(:response_status) { 200 }

  before do
    stub_request(:get, /graph.facebook.com/)
      .to_return(status: response_status, body: graph_response.to_json)
  end

  it 'loads profile and fetches user' do
    expect(Auth::Facebook::FetchUser)
      .to receive(:run).with(instance_of(OpenStruct)).and_return(user)

    expect(subject).to be(user)
  end

  context 'when token invalid' do
    let(:graph_response) { { error: { type: 'OAuthException' } } }
    let(:response_status) { 401 }

    it { is_expected.to be_nil }
  end
end
