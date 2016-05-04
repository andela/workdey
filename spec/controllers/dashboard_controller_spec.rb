require "rails_helper"

RSpec.describe DashboardController, type: :controller do
  before(:all) do
    @user = create(:user, user_type: "taskee", has_taken_quiz: true)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "GET #home" do
    it "returns the percentage for a taskee with skillset" do
      get :home
      expect(assigns[:completion_percentage]).to eq 27
    end
  end
end
