require "rails_helper"

RSpec.describe Enquiry, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:notifications) }
  it { should validate_presence_of(:question) }

  let(:user) { create(:user, confirmed: true) }

  let(:admin) { create(:user, confirmed: true)}

  describe ".answered" do
    context "when enquiry is unanswered" do
      before { create(:enquiry, user_id: user.id) }

      it "returns empty array of answered enquiries" do
        answered_enquiries = Enquiry.answered(user)
        expect(answered_enquiries.size).to eq(0)
      end

      context "when user is admin" do
        it "returns a admin's unread notifications" do
          unread_notifications = Notification.unread(admin)
          expect(unread_notifications.size).to eq(1)
        end
      end

      context "when user is artisan or tasker" do
        it "returns an empty array of notifications" do
          unread_notifications = Notification.unread(admin)
          expect(unread_notifications.size).to eq(0)
        end
      end
    end

    context "when enquiry is answered" do
      before { create(:enquiry, user_id: user.id, answered: true) }

      it "returns a list of user's answered enquiries" do
        answered_enquiries = Enquiry.answered(user)
        expect(answered_enquiries.size).to eq(1)
      end

      context "when user is admin" do
        it "returns empty array of notifications" do
          unread_notifications = Notification.unread(admin)
          expect(unread_notifications.size).to eq(0)
        end
      end

      context "when user is tasker or artisan" do
        it "returns a users unseen notifications" do
          unread_notifications = Notification.unread(user)
          expect(unread_notifications.size).to eq(1)
        end
      end
    end
  end
end
