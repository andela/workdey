require 'rails_helper'

RSpec.describe TaskeesController, type: :controller do
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
