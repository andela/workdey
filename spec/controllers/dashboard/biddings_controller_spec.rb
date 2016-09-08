# frozen_string_literal: true
require "rails_helper"

RSpec.describe Dashboard::BidsController, type: :controller do
  let(:taskee) { create(:user, user_type: "taskee") }
  let(:tasker) { create(:user) }
  let(:task) { create(:task, tasker_id: tasker.id) }
  before(:each) do
    create_list(:bid, 3, user_id: taskee.id, task_id: task.id)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(taskee)
  end

  describe "GET #new" do
    before(:each) { get :new, task_id: task.id }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "assigns a new instance of bid" do
      expect(assigns(:bid)).to be_a Bid
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before(:each) { get :edit, id: Bid.last.id }

    it "renders the edit template" do
      expect(response).to render_template :edit
    end
    it "assigns a bid to a varaible" do
      expect(assigns(:bid)).to eql Bid.last
    end
  end

  describe "GET #create" do
    context "when parameters are valid" do
      before do
        get :create, bid: attributes_for(:bid), task_id: task.id
      end
      it { expect(response).to redirect_to dashboard_task_path(task) }
    end
    context "when parameters are invalid" do
      it "should render the new page if bid fails to save" do
        get :create,
            bid: { price: 1000 },
            task_id: task.id
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #update" do
    context "when parameters are valid" do
      before do
        get :update, id: Bid.last.id, bid: attributes_for(:bid)
      end
      it { expect(response).to redirect_to dashboard_task_path(task) }
    end
    context "when parameters are invalid" do
      it "should render the new page if bid fails to update" do
        get :update,
            id: Bid.last.id,
            bid: { price: 1000 },
            task_id: task.id
        expect(response).to render_template :edit
      end
    end
  end

  describe "GET #destroy" do
    context "when there is no call to delete" do
      it { expect(Bid.count).to eql 3 }
    end
    context "when there is a call to delete" do
      before do
        get :destroy, id: Bid.last.id, task_id: task.id
      end
      it { expect(response).to redirect_to dashboard_task_path(task) }
      it { expect(Bid.count).to eql 2 }
    end
  end
end
