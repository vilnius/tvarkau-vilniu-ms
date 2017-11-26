# frozen_string_literal: true

RSpec.describe 'OAuth2' do
  let(:client) do
    OAuth2::Client.new(client_id, client_secret) do |b|
      b.request :url_encoded
      b.adapter :rack, Rails.application
    end
  end

  let(:client_id) { app.uid }
  let(:client_secret) { nil }
  let(:app) { create(:oauth_application) }
  let(:doorkeeper_token) { Doorkeeper::AccessToken.last }

  shared_examples 'not creating token' do
    it 'does not create token' do
      expect { subject }.to raise_error(OAuth2::Error)
      expect(doorkeeper_token).to be_nil
    end
  end

  describe 'password grant' do
    subject(:token) { client.password.get_token(username, password, scope: scope) }

    let(:scope) { 'public' }
    let(:username) { nil }
    let(:password) { nil }

    context 'with platform code only' do
      it_behaves_like 'not creating token'
    end

    context 'with invalid client id' do
      let(:client_id) { 'invalid' }
      it_behaves_like 'not creating token'
    end

    context 'with user' do
      let(:username) { user.email }
      let(:user) { create(:user) }
      let(:scope) { 'user' }

      context 'and valid password' do
        let(:password) { 'test123' }

        it 'gets token' do
          expect(token).not_to be_expired
          expect(doorkeeper_token.resource_owner_id).to eq(user.id)
          expect(doorkeeper_token.application).to eq(app)
        end
      end

      context 'and invalid password' do
        let(:password) { 'test1234' }
        it_behaves_like 'not creating token'
      end
    end
  end

  describe 'assertion grant' do
    subject(:token) { client.get_token(params) }

    let(:params) do
      { scope: scope, provider: provider, assertion: assertion, grant_type: 'assertion' }
    end

    let(:scope) { 'user' }
    let(:assertion) { 'token123' }

    context 'with google' do
      let(:provider) { 'google' }
      let(:google_profile) { build(:google_profile) }

      before do
        expect(Auth::Google::Profile).to(
          receive(:from_token).with(assertion).and_return(google_profile)
        )
      end

      context 'when user does not exist' do
        it 'gets creates user and gets token' do
          expect(token).not_to be_expired
          expect(doorkeeper_token.resource_owner_id).to be_present
        end
      end

      context 'when user exists' do
        let!(:user) { create(:user, email: google_profile.email) }

        it 'gets token' do
          expect(token).not_to be_expired
          expect(doorkeeper_token.resource_owner_id).to eq(user.id)
        end
      end

      context 'when assertion is invalid' do
        let(:google_profile) { nil }
        it_behaves_like 'not creating token'
      end
    end

    context 'with invalid provider' do
      let(:provider) { 'unknown' }
      it_behaves_like 'not creating token'
    end
  end
end
