# frozen_string_literal: true

RSpec.describe Auth::ViispController do
  let(:ticket) { 'abc' }
  let(:return_to_url) { 'https://test.localhost' }

  describe '#new' do
    subject { get :new, params: { return_to_url: return_to_url } }

    render_views

    it 'creates ticket and renders redirect' do
      expect(VIISP::Auth).to receive(:ticket).and_return(ticket)
      expect(subject).to be_success
      expect(response.body).to include(ticket)
    end
  end

  describe '#create' do
    subject { post :create, params: { return_to_url: return_to_url, ticket: ticket } }

    it 'to return url with ticket' do
      expect(subject).to redirect_to(/#{ticket}/)
    end

    context 'when return url is not set' do
      let(:return_to_url) { nil }

      it 'to renders json' do
        expect(subject).to be_success
        expect(JSON.parse(response.body)).to include('ticket' => ticket)
      end
    end
  end
end
