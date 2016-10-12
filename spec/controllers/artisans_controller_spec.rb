require "rails_helper"

RSpec.describe ArtisansController, type: :controller do
  describe "#index" do
    let(:user) { create(:user) }

    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)
      get :index
    end

    it "should get the index page successully" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end

    it "should assign a paginated collection to @users" do
      create_list(:user, 4, user_type: "artisan")
      expect(assigns(:artisans)).to be_a ActiveRecord::Relation
      expect(assigns(:artisans).count).to eql 4
    end
  end
end
