# frozen_string_literal: true

RSpec.describe Users::OmniauthCallbacksController do
  include Devise::Test::ControllerHelpers

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  shared_examples 'successful login' do
    let(:user) { build(:user) }

    it 'fetches user and redirects' do
      expect(Auth::ResourceOwnerFromOmniauth).to receive(:run).and_return(user)
      expect(subject).to be_redirect
    end
  end

  describe '#google_oauth2' do
    subject { post :google_oauth2 }
    it_behaves_like 'successful login'
  end

  describe '#facebook' do
    subject { post :google_oauth2 }
    it_behaves_like 'successful login'
  end
end
