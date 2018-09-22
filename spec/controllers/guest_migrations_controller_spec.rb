RSpec.describe GuestMigrationsController do
  describe '#create' do
    subject { api_post :create, params: { guest_token: guest_token.token } }

    let(:guest_token) { create(:oauth_token, user: guest_user) }
    let(:guest_user) { create(:user, guest: true) }
    let!(:report) { create(:report, user: guest_user) }

    it 'migrates guest data' do
      expect { subject }.to change { report.reload.user }.from(guest_user).to(user)
      expect(subject).to be_successful
    end
  end
end
