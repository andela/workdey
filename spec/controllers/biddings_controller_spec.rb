require 'rails_helper'

RSpec.describe BiddingsController, type: :controller do

  before(:all) do
    @user = create(:user)
  end

  describe "GET #new" do
    before(:each) do
      allow_any_instance_of(ApplicationController).
            to receive(:current_user).and_return(@user)
      get :new
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "assigns a new instance of bidding" do
      expect(assigns(:bidding)).to be_a Bidding
    end
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET #index" do
     before(:each) do
      allow_any_instance_of(ApplicationController).
            to receive(:current_user).and_return(@user)
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the index template" do
      expect(response).to render_template :index
    end
    it "assigns user's biddings to biddings" do

      expect(assigns(biddings)).to
  end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:created)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
