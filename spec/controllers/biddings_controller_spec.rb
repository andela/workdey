# frozen_string_literal: true
require "rails_helper"

RSpec.describe BiddingsController, type: :controller do
  let(:user) { build_stubbed(:user) }
  before(:each) do
    create_list(:bidding, 3, tasker_id: user.id)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
  end

  describe "GET #new" do
    before(:each) { get :new }

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
    before(:each) { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the index template" do
      expect(response).to render_template :index
    end
    it "assigns user's biddings to biddings" do
      expect(assigns(:biddings).to_a).to eql user.biddings.to_a
    end
  end

  describe "GET #edit" do
    before(:each) { get :edit, id: Bidding.last.id }

    it "renders the new template" do
      expect(response).to render_template :new
    end
    it "assigns a bidding to a varaible" do
      expect(assigns(:bidding)).to eql Bidding.last
    end
  end

  describe "GET #create" do
    context "when parameters are valid" do
      before do
        get :create, bidding: attributes_for(:bidding)
      end
      it { expect(response).to redirect_to biddings_path }
    end
    context "when parameters are invalid" do
      it "should render the new page if bidding fails to save" do
        get :create,
            bidding: { name: "Cleaning",
                       description: "",
                       price_range: "2000",
                       tasker_id: nil }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #update" do
    context "when parameters are valid" do
      before do
        get :update, id: Bidding.last.id, bidding: attributes_for(:bidding)
      end
      it { expect(response).to redirect_to biddings_path }
    end
    context "when parameters are invalid" do
      it "should render the new page if bidding fails to update" do
        get :update,
            id: Bidding.last.id,
            bidding: {
              name: "Cleaning",
              description: "",
              price_range: "2000"
            }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #destroy" do
    context "when there is no call to delete" do
      it { expect(Bidding.count).to eql 3 }
    end
    context "when there is a call to delete" do
      before do
        get :destroy, id: Bidding.last.id
      end
      it { expect(response).to redirect_to biddings_path }
      it { expect(Bidding.count).to eql 2 }
    end
  end
end
