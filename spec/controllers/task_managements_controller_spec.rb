require "rails_helper"

RSpec.describe TaskManagementsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:ironing) { create(:task_management, task_desc: Faker::Lorem.sentence) }
  let!(:cleaning) { create(:task_management, task_desc: Faker::Lorem.sentence) }
  let!(:carpentry) do
    create(:task_management, task_desc: Faker::Lorem.sentence)
  end
  let!(:washing) { create(:task_management, task_desc: Faker::Lorem.sentence) }

  describe "GET #index" do
    context "when no user is logged in" do
      before do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(nil)
        user.tasks_created = [ironing, cleaning]
        user.tasks_given = [carpentry, washing]
      end
      it "should have a redirect status" do
        get :index
        expect(response).to have_http_status(302)
      end
    end
    context "when a user is logged in" do
      before(:each) do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(user)
        user.tasks_created = [ironing, cleaning]
        user.tasks_given = [carpentry, washing]
      end
      it "should render the index page" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to render_template("index")
      end
      it "assigns tasks created to tasker" do
        get :index
        expect(assigns(:tasks)).to eql user.tasks_created.to_a
      end
      it "assigns tasks given to taskee" do
        user.update_attribute(:user_type, "taskee")
        get :index
        expect(assigns(:tasks)).to eql user.tasks_given.paid_for.to_a
      end
    end
  end
end
