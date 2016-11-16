require "rails_helper"

RSpec.describe ServiceRatingsController, type: :controller do
  before(:each) do
    @tasker = create(:user)
    @artisan = create(:user, user_type: "artisan")
    @service = create(:service, tasker: @tasker, artisan: @artisan)
    @service_second = create(:service, tasker: @tasker, artisan: @artisan)
  end

  describe "#index" do
    context "user_type is admin" do
      let(:user) { create :user, user_type: "admin" }

      before(:each) do
        stub_current_user(user)
        get :index
      end

      it "assigns service_rating records to user_ratings" do
        expect(assigns(:service_ratings)).to eq ServiceRating.get_ratings(user)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context "user_type is tasker" do
      before(:each) do
        stub_current_user(@tasker)
        get :index
      end

      it "assigns service_rating records to user_ratings" do
        create :service_rating,
               category: ServiceRating.categories[:artisan_to_tasker],
               service: @service

        expect(
          assigns(:service_ratings)
        ).to eq ServiceRating.get_ratings(@tasker)
        expect(
          assigns(:service_ratings)[0].service.tasker.id
        ).to eq @tasker.id
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context "user_type is artisan" do
      before(:each) do
        stub_current_user(@artisan)
        get :index
      end

      it "assigns service_rating records to user_ratings" do
        create :service_rating, service: @service

        expect(
          assigns(:service_ratings)
        ).to eq ServiceRating.get_ratings(@artisan)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end
  end

  describe "#show" do
    subject(:service_rating) { create :service_rating, service: @service }

    before(:each) { get :show, id: service_rating.id }

    it "renders the show view" do
      expect(response).to render_template("show")
    end
  end

  describe "#view_rating_details" do
    subject(:service_rating) { create :service_rating, service: @service }

    before(:each) { get :view_rating_details, id: service_rating.id }

    it "renders the show view" do
      expect(response).to render_template("view_rating_details")
    end
  end

  describe "#new" do
    before(:each) do
      get :new, service_id: @service.id
    end

    it "assigns a service to a rating" do
      expect(assigns(:service_rating).service.id).to eq @service.id
    end

    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    before(:each) do
      stub_current_user(@tasker)
    end

    let(:service_rating_create_request) do
      post :create,
           service_rating: attributes_for(
             :service_rating,
             service_id: @service.id
           )
    end

    it "create a new service_rating" do
      expect { service_rating_create_request }.to change(
        ServiceRating,
        :count
      ).by(1)
    end

    it "returns a status code of 302" do
      service_rating_create_request
      expect(response.status).to eq 302
    end
  end
end
