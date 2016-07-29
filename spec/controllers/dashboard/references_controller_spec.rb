require "rails_helper"

RSpec.describe Dashboard::ReferencesController, type: :controller do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
  end

  describe "GET #new" do
    let!(:req) { get :new }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "assigns user's skillsets to taskee_skillsets" do
      expect(assigns(:taskee_skillsets)).to eql(user.skillsets)
    end
  end

  describe "GET #index" do
    let!(:req) { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "assigns user's references to references" do
      expect(assigns(:references)).to eql(user.references)
    end
  end

  describe "POST #create" do
    let!(:req) do
      post :create,
           reference: {
             firstname: Faker::Name.first_name,
             lastname: Faker::Name.last_name,
             email: Faker::Internet.email,
             relationship: "Professional",
             skillsets: ["Plumbing"]
           }
    end

    it "returns a http created" do
      expect(response).to have_http_status(302)
    end

    it "creates a new reference" do
      expect(Reference.count).to eq(1)
    end
  end
end
