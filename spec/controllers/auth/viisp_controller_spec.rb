# frozen_string_literal: true

RSpec.describe Auth::ViispController do
  let(:ticket) { 'abc' }
  let(:redirect_uri) { 'https://localhost:3000' }

  describe '#new' do
    subject { get :new, params: { redirect_uri: redirect_uri } }

    render_views

    it 'creates ticket and renders redirect' do
      expect(VIISP::Auth).to receive(:ticket).and_return(ticket)
      expect(subject).to be_success
      expect(response.body).to include(ticket)
    end

    context 'with invalid redirect uri' do
      let(:redirect_uri) { 'https://fake.net' }
      it { is_expected.to be_forbidden }
    end
  end

  describe '#create' do
    subject { post :create, params: { redirect_uri: redirect_uri, ticket: ticket } }

    it 'to return url with ticket' do
      expect(subject).to redirect_to(/#{ticket}/)
    end

    context 'when return url is not set' do
      let(:redirect_uri) { nil }

      it 'to renders json' do
        expect(subject).to be_success
        expect(JSON.parse(response.body)).to include('ticket' => ticket)
      end
    end

    context 'with invalid redirect uri' do
      let(:redirect_uri) { 'https://fake.net' }
      it { is_expected.to be_forbidden }
    end
  end
end
