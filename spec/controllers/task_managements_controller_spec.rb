require "rails_helper"

RSpec.describe TaskManagementsController, type: :controller do
  let(:assign_tasks) { assigns(:tasks) }

  before(:all) do
    @tasker = create(:user)
    @taskee = create(:user, user_type: "taskee")
    ironing = create(:task_management, task_desc: Faker::Lorem.sentence)
    cleaning = create(:task_management, task_desc: Faker::Lorem.sentence)
    carpentry = create(:task_management, task_desc: Faker::Lorem.sentence)
    washing = create(:task_management, task_desc: Faker::Lorem.sentence)
    @tasker.tasks_created = [cleaning, ironing]
    @taskee.tasks_given = [carpentry, washing]
  end
  describe "GET #index" do
    context "when no user is logged in" do
      before do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(nil)
      end
      it "should have a redirect status" do
        get :index
        expect(response).to have_http_status(302)
      end
    end
    context "when a user is logged in" do
      before do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(@tasker)
      end
      it "should render the index page" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to render_template("index")
      end
      it "assigns tasks created to tasker" do
        get :index
        assign_tasks
        expect(@tasker.tasks_created.size).to eql(2)
      end
      it "assigns tasks given to taskee" do
        get :index
        assign_tasks
        expect(@taskee.tasks_given.size).to eql(2)
      end
    end
  end
end
