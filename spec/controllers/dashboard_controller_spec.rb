require "rails_helper"
include DashboardHelper

RSpec.describe DashboardController, type: :controller do
  describe "GET #home" do
    context "when a taskee  without skillsets visits the dashboard " do
      let(:user) do
        create(:user, user_type: "taskee",
                      has_taken_quiz: true,
                      status: "accepted",
                      reason: "good")
      end
      before(:each) do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(user)
        get :home
      end

      it "returns the percentage for a taskee with skillset" do
        expect(assigns[:completion_percentage]).to eq 85
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
        @user.skillsets << create(:skillset)
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(@user)
        get :home
      end

      before { stub_current_user(@user) }

      let!(:req) { get :home }

      it "returns the percentage for a taskee with skillset" do
        expect(assigns[:completion_percentage]).not_to be_nil
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
    user_attr = {
      user_type: "tasker",
      has_taken_quiz: true,
      street_address: Faker::Address.street_address,
      birthday: Date.today,
      status: "accepted",
      reason: "good"
    }

    let(:user) { create(:user, user_attr) }

    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)
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

  describe "POST #set_role" do
    let(:user) { create(:user, user_type: nil, has_taken_quiz: false) }
    before(:each) { stub_current_user(user) }
    let(:role) { "tasker" }

    let!(:req) { post :set_role, role: role, format: :js }

    context "when tasker" do
      it "sets the user type to tasker" do
        expect(user.user_type).to eq(role)
      end

      it "sets user as tasken quiz" do
        expect(user.has_taken_quiz).to be true
      end
    end

    context "when taskee" do
      let(:role) { "taskee" }

      it "assigns skillsets to @skillsets" do
        expect(assigns(:skillsets)).to eq(Skillset.all)
      end
    end
  end

  describe "POST #create_skillset" do
    let(:skillsets) { create_list(:skillset, 4) }
    let(:user) { create(:user, user_type: nil, has_taken_quiz: false) }
    before(:each) { stub_current_user(user) }
    let(:skill_ids) { [skillsets[0].id, skillsets[1].id] }

    let!(:req) { post :create_skillset, skillsets: skill_ids }

    context "when params[:skillsets] is present" do
      context "when valid params" do
        it "sets user skill set" do
          user_skill_ids = user.skillsets.map(&:id)
          expect(user.skillsets).not_to be_nil
          expect(user_skill_ids).not_to be_nil
        end

        it "sets the user type as taskee" do
          expect(user.taskee?).to be true
        end

        it "redirects to quiz path" do
          expect(response).to redirect_to(quiz_path)
        end
      end

      context "when invalid params" do
        let(:skill_ids) { [100, 200] }

        it "redirects to role path" do
          expect(response).to redirect_to(role_path)
          expect(flash[:notice]).
            to match(/Something went wrong. Please try again/)
        end
      end
    end

    context "when params[:skillsets] id blank" do
      let(:skill_ids) { [] }

      it "redirects to role path" do
        expect(response).to redirect_to(role_path)
        expect(flash[:notice]).to match(/Please choose at least one skill./)
      end
    end
  end
end
