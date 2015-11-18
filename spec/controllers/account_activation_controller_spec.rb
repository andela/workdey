require 'rails_helper'

RSpec.describe AccountActivationController, type: :controller do

  describe "GET #confirm_email" do
    it "returns http success" do
      get :confirm_email
      expect(response).to have_http_status(:success)
    end
  end

end
