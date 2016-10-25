require "rails_helper"

RSpec.describe Admin::RatingsController, type: :controller do
  before(:each) do
    @admin = create(:user, user_type: "admin")
    @non_admin = create(:user, user_type: "tasker")
  end

  describe "GET#new" do
    context "when user is admin" do
      before(:each) do
        stub_current_user(@admin)
        get :new, user_id: 1
      end

      it "renders new rating template" do
        expect(response).to render_template "new"
      end

      it "responds with status code OK" do
        expect(response.status).to eq 200
      end
    end

    context "when user is not admin" do
      before(:each) do
        stub_current_user(@non_admin)
        get :new, user_id: 1
      end
      it "denies the user access to the rating resource" do
        expect(flash[:error]).to be_present
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
