# frozen_string_literal: true
require "rails_helper"

RSpec.describe NotificationsController, type: :controller do
  let(:taskee) { create(:user, user_attr.merge(user_type: "taskee")) }
  let(:tasker) { create(:user, user_attr.merge(user_type: "tasker")) }
  let(:skillset) { create(:skillset) }
  let(:price_range) do
    [
      Faker::Commerce.price(2000..3000).to_s,
      Faker::Commerce.price(3001..5000).to_s
    ]
  end
  let(:task) do
    create(
      :task,
      skillset_id: skillset.id,
      tasker_id: tasker.id,
      price_range: price_range,
      broadcasted: true
    )
  end
  let(:notification) do
    create(
      :notification,
      notifiable_id: task.id,
      receiver_id: taskee.id,
      sender_id: tasker.id,
      notifiable_type: "Task"
    )
  end

  before(:each) { stub_current_user(tasker) }

  describe "GET #index" do
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
        notification = Notification.unread(tasker)
        expect(assigns(:notifications)).to eq(notification)
      end
    end
  end

  shared_examples "a show GET request" do
    it "sets notification as @notification" do
      expect(assigns(:notification)).to eq(notification)
    end

    it "updates notification as read" do
      expect(assigns(:notification).read).to be true
    end
  end

  describe "GET #show" do
    context "when AJAX request" do
      before { xhr :get, :show, id: notification.id, format: :js }

      it_behaves_like "a show GET request"

      it "returns a status code 200" do
        expect(response.status).to eq(200)
      end
    end

    context "when normal request" do
      before do
        get :show, id: notification.id
      end

      it_behaves_like "a show GET request"

      it "returns a status code 200" do
        expect(response.status).to eq(302)
      end
    end
  end

  shared_examples "an update PUT request" do
    it "sets notification as @notification" do
      expect(assigns(:notification)).to eq(notification)
    end

    it "updates the notification as read" do
      expect(assigns(:notification).read).to be true
    end

    it "returns a status code 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "#update" do
    context "when AJAX request" do
      before do
        xhr :put,
            :update,
            id: notification.id,
            notifiable_attr_to_update: { name: "Updated" },
            message: "a message",
            reply_to_sender: true
      end

      it_behaves_like "an update PUT request"
    end

    context "when a normal request" do
      before do
        put :update, id: notification.id,
                     notification: {
                       notifiable_attr_to_update: { name: "Updated" },
                       message: "a message",
                       reply_to_sender: true
                     }
      end

      it_behaves_like "an update PUT request"
    end
  end
end
