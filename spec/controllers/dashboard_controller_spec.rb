require "rails_helper"

RSpec.describe DashboardController, type: :controller do
  describe "GET #home" do
    context "when a taskee  without skillsets visits the dashboard " do
      before(:each) do
        @user = create(:user, user_type: "taskee", has_taken_quiz: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        get :home
      end
      it "returns the percentage for a taskee with skillset" do
        expect(assigns[:completion_percentage]).to eq 73
      end
      it "returns a status code of 200" do
        expect(response.status).to eq 200
      end
      it "renders the home template" do
        expect(response).to render_template :home
      end
    end

    context "when a taskee with skillset visits the dashboard" do
      before(:each) do
        @user = create(:user, user_type: "taskee", has_taken_quiz: true)
        @skillset = create(:skillset, user: @user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        get :home
      end
      it "returns the percentage for a taskee with skillset" do
        expect(assigns[:completion_percentage]).to eq 82
      end
      it "returns a status code of 200" do
        expect(response.status).to eq 200
      end
      it "renders the home template" do
        expect(response).to render_template :home
      end
    end
  end

  context "when a tasker with complete profile visits the dashboard" do
    before(:each) do
      @user = create(:user, user_type: "tasker", has_taken_quiz: true, street_address: "55, moleye sreet", birthday: Date.today)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      get :home
    end
    it "returns the percentage for a taskee with skillset" do
      expect(assigns[:completion_percentage]).to eq 100
    end
    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end
    it "renders the home template" do
      expect(response).to render_template :home
    end
  end
end
