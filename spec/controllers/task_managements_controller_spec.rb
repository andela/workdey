require "rails_helper"

RSpec.describe TaskManagementsController, type: :controller do
  before(:all) do
    @user = create(:user)
    ironing = create(:task_management, task_desc: "Iron these clothes for me")
    cleaning = create(:task_management, task_desc: "Clean my house for me")
    carpentry = create(:task_management, task_desc: "Make me some chairs")
    washing = create(:task_management, task_desc: "Wash these clothes for me")
    @user.tasks_created = [ironing, cleaning]
    @user.tasks_given = [carpentry, washing]
  end
  describe "GET #index" do
    context "no user is logged in" do
      before do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(nil)
      end
      it "should have a redirect status" do
        get :index
        expect(response).to have_http_status(302)
      end
    end
    context "it should render the tasks logs page when a user is logged in" do
      before do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(@user)
      end
      it "render the index page" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to render_template("index")
      end
      it "assigns tasks created to @tasks" do
        get :index
        expect(assigns(:tasks)).to eql @user.tasks_created.to_a
      end
      it "assigns tasks given to @tasks" do
        @user.update_attribute(:user_type, "taskee")
        get :index
        expect(assigns(:tasks)).to eql @user.tasks_given
      end
    end
  end
end
