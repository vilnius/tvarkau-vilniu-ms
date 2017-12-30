RSpec.describe ApiController do
  controller(described_class) do
    def index
      {}
    end
  end

  subject { api_get :index }

  describe 'authorization' do
    context 'with valid token' do
      let(:oauth_token) { create(:oauth_token, user: user) }
      let(:user) { create(:user) }

      it 'authorizes' do
        expect(subject).to be_success
        expect(controller.send(:current_user)).to eq(user)
      end
    end

    context 'with invalid token' do
      let(:token) { 'invalid' }
      it { is_expected.to be_unauthorized }
    end

    context 'invalid auth header' do
      before { request.headers['Authorization'] = 'invalid' }
      it { is_expected.to be_unauthorized }
    end
  end
end
