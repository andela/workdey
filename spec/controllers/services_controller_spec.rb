require "rails_helper"

RSpec.describe ServicesController, type: :controller do
  let(:user) { create :user }
  subject(:service) { create :service }

  describe "#index" do
    before(:each) do
      stub_current_user(user)
      get :index
    end

    it "returns a list of unassigned service requests" do
      expect(assigns(:services)).to eq Service.pending_requests(user)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

  describe "#show" do
    before(:each) { get :show, id: service.id }

    it "renders the show view" do
      expect(response).to render_template("show")
    end
  end

  describe "#new" do
    before(:each) { get :new }

    it "assigns service instance to service" do
      expect(assigns(:service)).to be_a_new(Service)
    end

    it "returns a status code 200" do
      expect(response.status).to eq 200
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    let(:skillset) { create :skillset }
    before(:each) do
      stub_current_user(user)
      ActiveJob::Base.queue_adapter = :test
    end

    context "with valid attributes" do
      let(:service_request_create) do
        post :create, service: attributes_for(:service,
                                              skillset_id: skillset.id)
      end

      it "creates a new service" do
        expect { service_request_create }.to change(Service, :count).by(1)
      end

      it "enques a background job" do
        service_request_create
        expect(ServiceAssignmentJob).to have_been_enqueued
        expect(ServiceAssignmentJob).to have_been_enqueued.on_queue("default")
      end

      it "returns a status code of 302" do
        service_request_create
        expect(response.status).to eq 302
      end

      it "redirects to the show view" do
        service_request_create
        expect(response).to redirect_to Service.last
      end
    end

    context "with invalid attributes" do
      let(:invalid_service_request_create) do
        post :create, service: attributes_for(:service,
                                              title: nil,
                                              desription: nil,
                                              skillset_id: skillset.id)
      end

      it "does not create a new service" do
        expect { invalid_service_request_create }.to_not change(Service, :count)
      end

      it "renders to the show view" do
        invalid_service_request_create
        expect(response).to redirect_to(new_service_path)
      end
    end
  end
end
