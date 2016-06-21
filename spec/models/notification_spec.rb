require "rails_helper"

RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }

  let!(:notification) { create(:notification, receiver: user) }

  it { is_expected.to belong_to(:sender).class_name("User") }

  it { is_expected.to belong_to(:receiver).class_name("User") }

  it { is_expected.to belong_to(:notifiable) }

  describe '#update_as_viewed' do
    it "sets a notification as read" do
      notification.update_as_viewed
      expect(notification.read).to be true
    end
  end

  describe ".unseen" do
    context "when unseen" do
      before { user.notifications.update_all(user_notified: false) }

      it "returns a users unseen notifications" do
        unseen_notifications = Notification.unseen(user)
        expect(unseen_notifications.size).to eq(1)
      end
    end

    context "when seen" do
      before { user.notifications.update_all(user_notified: true) }

      it "returns empty array" do
        unseen_notifications = Notification.unseen(user)
        expect(unseen_notifications.size).to eq(0)
      end
    end
  end

  describe ".unread" do
    context "when unread" do
      it "returns the unread notifications" do
        unread_notifications = Notification.unread(user)
        expect(unread_notifications.size).to eq(1)
      end
    end

    context "when read" do
      before { user.notifications.update_all(read: true) }

      it "returns empty array" do
        unread_notifications = Notification.unread(user)
        expect(unread_notifications.size).to eq(0)
      end
    end
  end

  describe ".update_as_notified" do
    it "updates notifications as seen" do
      Notification.update_as_notified(user)
      unseen = Notification.unseen(user)
      expect(unseen.size).to eq(0)
    end
  end
end
