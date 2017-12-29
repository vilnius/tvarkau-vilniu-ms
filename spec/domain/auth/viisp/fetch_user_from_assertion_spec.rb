RSpec.describe Auth::Viisp::FetchUserFromAssertion, '.run' do
  subject { described_class.run(ticket) }

  let(:ticket) { double }
  let(:identity) { double }
  let(:user) { double }

  context 'when token invalid' do
    before do
      expect(VIISP::Auth)
        .to receive(:identity).with(ticket: ticket).and_raise(VIISP::Auth::RequestError)
    end

    it { is_expected.to be_nil }
  end

  context 'when token is valid' do
    before do
      expect(VIISP::Auth).to receive(:identity).with(ticket: ticket).and_return(identity)
    end

    it 'fetches user' do
      expect(Auth::Viisp::FetchUser).to receive(:run).with(identity).and_return(user)
      expect(subject).to be(user)
    end
  end
end
