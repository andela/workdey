require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(302)
    end
  end

end
