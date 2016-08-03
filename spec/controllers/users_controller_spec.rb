require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "Post#create" do
    context "when user try to create account with valid data" do
      let(:user_valid_request) { post :create, user: attributes_for(:user) }
      it "creates a new user" do
        expect do
          user_valid_request
        end.to change(User, :count).by 1
      end

      it "redirects to dashboard_path" do
        user_valid_request
        expect(response).to redirect_to dashboard_path
      end
    end

    context "when user tries to create account with invalid data" do
      before(:each) do
        post :create, user: attributes_for(:user, firstname: nil)
      end

      it "renders new template" do
        expect(response).to render_template :new
      end

      it "returns error 'cant be blank' messages" do
        expect(assigns[:user].errors[:firstname]).to include "can't be blank"
      end
    end
  end

  describe "#index" do
    before(:each) do
      get :index
    end
    it "should get the index page successully" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
    it "should assign a paginated collection to @users" do
      create_list(:user, 4, user_type: "taskee")
      expect(assigns(:users)).to be_a ActiveRecord::Relation
      expect(assigns(:users).count).to eql 4
    end
  end
end
