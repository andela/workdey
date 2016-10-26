require "rails_helper"

RSpec.describe EnquiriesController, type: :controller do
  let!(:user) { create(:user, confirmed: true) }
  let!(:admin) { create(:user, user_type: "admin", confirmed: true) }
  let!(:enquiry) { create(:enquiry, user_id: user.id) }
  let!(:notification) do
    create(:notification,
           notifiable: enquiry,
           receiver_id: admin.id,
           sender_id: user.id)
  end


  describe "POST #create" do
    before(:each) { stub_current_user(user) }
    let(:notification_request) { post :create, enquiry: attributes_for(:enquiry, user_id: user.id) }

    it "returns a status code 302" do
      notification_request
      expect(response.status).to eq(302)
    end

    it "sends a notification to the admin" do
      expect{ notification_request }.to change(Notification.unread(admin), :count).by(1)
    end
  end
end
