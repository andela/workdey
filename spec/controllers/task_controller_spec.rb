require "rails_helper"

RSpec.describe TasksController, type: :controller do
  let!(:user) do
    create(:user, user_attr.merge(user_type: "tasker"))
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
  end

  describe "POST create" do
    let(:task_param) do
      task_attr.merge(
        name: Faker::Lorem.word,
        location: "",
        skillset_id: skillset.id
      )
    end

    let!(:skillset) { create(:skillset, user: user) }

    context "when users try to create a task with valid data" do
      it "saves the task" do
        expect do
          post :create, task: task_param
        end.to change(Task, :count).by(1)
      end

      it "redirects to dashboard" do
        post :create, task: task_param
        expect(response).to redirect_to dashboard_path
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

  describe "POST search" do
    context "when a skillset with a task is supplied as search params" do
      let!(:skillset) {create(:skillset)}
      let!(:task) {create(:task, task_attr.merge(tasker_id: user.id, skillset_id: skillset.id))}

      before(:each) do
        post :search, need: skillset.name
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
