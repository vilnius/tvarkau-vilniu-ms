RSpec.describe Auth::Facebook::FetchUser, '.run' do
  subject { described_class.run(token) }

  let(:token) { double(:facebook_token) }

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

  context 'when token invalid' do
    let(:graph_response) { { error: { type: 'OAuthException' } } }
    let(:response_status) { 401 }

    it { is_expected.to be_nil }
  end

  context 'when user does not exist' do
    it 'creates user' do
      expect(subject).to be_instance_of(User)
      expect(subject).to be_persisted
      expect(subject.facebook_id).to eq(graph_response[:id])
      expect(subject.email).to eq(graph_response[:email])
      expect(subject.name).to eq('Gediminas Gediminaitis')
    end
  end

  context 'when user exists' do
    let!(:user) { create(:user, email: graph_response[:email]) }

    it 'fetches user' do
      expect(subject).to eq(user)
    end
  end
end
