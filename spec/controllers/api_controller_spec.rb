RSpec.describe ApiController do
  controller(described_class) do
    def index
      {}
    end
  end

  subject { api_get :index }

  describe 'authorization' do
    context 'with valid user token' do
      let(:oauth_token) { create(:oauth_token, user: user) }
      let(:user) { create(:user) }

      it 'authorizes' do
        expect(subject).to be_successful
        expect(controller.send(:current_user)).to eq(user)
      end
    end

    context 'with valid anonymous token' do
      let(:oauth_token) { create(:oauth_token) }

      it 'authorizes' do
        expect(subject).to be_successful
        expect(controller.send(:current_user)).to be_guest
        expect(oauth_token.reload.resource_owner_id).to be_present
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
