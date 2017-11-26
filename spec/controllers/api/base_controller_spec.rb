RSpec.describe Api::BaseController do
  controller(Api::BaseController) do
    def index
      {}
    end
  end

  subject { api_get :index }

  describe 'authorization' do
    it { is_expected.to be_success }

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
