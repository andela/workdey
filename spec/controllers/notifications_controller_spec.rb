require "rails_helper"

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) }

  before(:each) { stub_current_user(user) }

  describe 'GET #index' do
    let(:notification) { create(:notification) }

    before { get :index }

    it "renders the index template" do
      expect(response).to render_template(:index)
    end

    it "returns a status code 200" do
      expect(response.status).to eq(200)
    end

    context "when notification is read" do
      before { notification.update(read: true) }

      it "returns no notifications" do
        expect(assigns(:notifications)).to be_empty
      end
    end

    context "when notification is unread" do
      it "returns the notification" do
        notification = Notification.unread(user)
        expect(assigns(:notifications)).to eq(notification)
      end
    end
  end
end
