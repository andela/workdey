require "rails_helper"

RSpec.describe AdminController, type: :controller do
  describe "GET #applications" do
    it "returns http success" do
      get :applications
      expect(response).to have_http_status(:success)
    end
  end
end
