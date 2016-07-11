require "rails_helper"

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @user = create(:user, user_attr.merge(user_type: "tasker"))
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  describe "POST create" do
    before(:all) do
      @task_param = task_attr.merge(
        name: Faker::Lorem.word,
        type: "assign",
        skillsets: "running",
        location: ""
      )
    end
    context "when users try to create a task with valid data" do
      it "saves the task" do
        expect do
          post :create, task: @task_param
        end.to change(Task, :count).by(1)
      end

      it "renders search result partials" do
        post :create, task: @task_param
        expect(response).to render_template("partials/search_result")
      end
    end

    context "when users try to create a task with invalid data" do
      before(:each) do
        post :create, task: @task_param.except(:name)
      end

      it "renders the new page" do
        expect(response).to render_template :new
      end

      it "returns error message in the task object" do
        expect(assigns[:task].errors[:name]).to include "can't be blank"
      end
    end
  end

  describe "GET #view_taskee" do
    it "renders partials/profile_view" do
      get :view_taskee, taskee_id: @user.id
      expect(response).to render_template("partials/profile_view")
    end
  end

  describe "GET assign" do
    it "redirects to dashboard_path" do
      task = create(:task, task_attr)
      get(
        :assign,
        taskee_id: @user.id,
        task_id: task.id,
        skillset: Faker::Lorem.word
      )
      expect(response).to redirect_to dashboard_path
    end
  end
end
