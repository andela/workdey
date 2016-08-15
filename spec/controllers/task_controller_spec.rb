require "rails_helper"

RSpec.describe Dashboard::TasksController, type: :controller do
  let!(:user) do
    create(:user, user_attr.merge(user_type: "tasker"))
  end
  let(:task) do
    attributes_for(:task, skillset_id: skillset.id, tasker_id: user.id)
  end
  before(:each) do
    @user = create(:user, user_attr.merge(user_type: "tasker"))
    @skillset = create(:skillset)
    @user.skillsets << @skillset
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  let(:price_range) do
    [
      Faker::Commerce.price(2000..3000).to_s,
      Faker::Commerce.price(3001..5000).to_s
    ]
  end

  describe "POST create" do
    let(:task_param) do
      {
        name: Faker::Lorem.word,
        location: "",
        skillset_id: @skillset.id,
        min_price: price_range[0],
        max_price: price_range[1]
      }
    end

    context "when users try to create a task with valid data" do
      it "saves the task" do
        expect do
          post :create, task: attributes_for(:task).merge(task_param)
        end.to change(Task, :count).by(1)
      end
    end

    context "when users try to create a task with invalid data" do
      before(:each) do
        post :create, task: task_param.except(:name)
      end

      it "renders the new page" do
        expect(response).to render_template :new
      end

      it "returns error message in the task object" do
        expect(assigns[:task].errors[:name]).to include "can't be blank"
      end
    end
  end

  describe "POST update" do
    let!(:task) do
      create(:task, skillset_id: @skillset.id, tasker_id: @user.id)
    end

    context "when a user broadcasts a task" do
      let(:message) { "Available Taskees have been notified" }

      it "updates the task's price range and broadcasted status" do
        put :update, id: task.id
        expect(assigns[:task].broadcasted).to be_truthy
      end
    end
  end

  describe "GET close_bid" do
    let!(:task) do
      create(
        :task,
        skillset_id: @skillset.id,
        tasker_id: @user.id,
        price_range: price_range,
        broadcasted: true
      )
    end
    let(:message) { "Bids successfully closed" }
    let!(:req) { get :close_bid, id: task.id }

    context "when a user closes bidding" do
      it "should update the task's broadcasted status" do
        expect(assigns[:task].broadcasted).to be_falsy
      end
      it { should set_flash[:notice].to message }
    end
  end

  describe "POST search" do
    context "when a skillset with a task is supplied as search params" do
      let!(:task) do
        create(
          :task,
          tasker_id: @user.id,
          skillset_id: @skillset.id,
          price_range: price_range
        )
      end

      before(:each) do
        post :search, need: @skillset.name
      end

      it "returns the task object that has the skillset" do
        expect(assigns[:tasks].first).to eq task
      end

      it "renders the search template" do
        expect(response).to render_template :search
      end
    end

    context "when a skillset without a task is supplied as search params" do
      it "returns an empty array" do
        post :search, need: Faker::Lorem.word
        expect(assigns[:tasks]).to eq []
      end
    end
  end
end
