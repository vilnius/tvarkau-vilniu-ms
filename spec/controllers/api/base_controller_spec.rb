RSpec.describe Api::BaseController do

  controller(Api::BaseController) do
    def index
      {}
    end
  end

  let(:params) { {} }

  subject do
    api_get :index, params
    response_json
  end

  describe '#load token' do
    context 'invalid token' do
      let(:params) { { token: nil } }
      its(['code']) { should == Api::BaseController::INVALID_TOKEN }
    end

    context 'invalid auth header' do
      before { request.headers['X-AUTH-TOKEN'] = '123' }
      let(:params) { { token: nil } }
      its(['code']) { should == Api::BaseController::INVALID_TOKEN }
    end
  end
end
