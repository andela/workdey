# frozen_string_literal: true
require "rails_helper"
include DashboardHelper

RSpec.describe DashboardController, type: :controller do
  describe "GET #home" do
    context "when a taskee  without skillsets visits the dashboard " do
      let(:user) { create(:user, user_type: "taskee", has_taken_quiz: true) }
      before(:each) do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(user)
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
      let(:user) { create(:user, user_type: "taskee", has_taken_quiz: true) }
      before(:each) do
        create(:skillset, user: user)
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).and_return(user)
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
    user_attr = {
      user_type: "tasker",
      has_taken_quiz: true,
      street_address: Faker::Address.street_address,
      birthday: Date.today
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
end
