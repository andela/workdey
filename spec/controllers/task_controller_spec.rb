require "rails_helper"

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @user = create(:user, user_attr.merge(user_type: "tasker"))
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  describe "POST create" do
    before(:each) do
      skillset = create(:skillset, user: @user)
      @task_param = task_attr.merge(
        name: Faker::Lorem.word,
        location: "",
        skillset_id: skillset.id
      )
    end

    context "when users try to create a task with valid data" do
      it "saves the task" do
        let(t);
        expect do
          post :create, task: @task_param
        end.to change(Task, :count).by(1)
      end

      it "redirects to dashboard" do
        post :create, task: @task_param
        expect(response).to redirect_to dashboard_path
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
end
