# frozen_string_literal: true
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
end
