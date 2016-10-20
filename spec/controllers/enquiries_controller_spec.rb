require "rails_helper"

RSpec.describe EnquiriesController, type: :controller do
  let(:user) { create(:user, confirmed: true) }
  let(:admin) { create(:user, user_type: "admin", confirmed: true) }
  let(:enquiry) { create(:enquiry, user_id: user.id) }
  let(:notification) do
    create(:notification,
           notifiable_id: enquiry.id,
           notifiable_type: "Enquiry",
           receiver_id: admin.id,
           sender_id: user.id)
  end

  before(:each) { stub_current_user(admin) }

  describe "GET #index" do
    before { get :index }

    it "renders the index template" do
      expect(response).to render_template(:index)
    end

    it "returns a status code 200" do
      expect(response.status).to eq(200)
    end

    context "when enquiry is unanswered" do
      it "returns the enquiry" do
        expect(assigns(:enquiries)).to eq(enquiry)
      end
    end

    context "when enquiry is answered" do
      before { enquiry.update(answered: true) }

      it "returns no enquiries" do
        expect(assigns(:enquiries)).to be_empty
      end
    end
  end

  describe "POST #create" do
    before do
      stub_current_user(user)
      post :create, params: {
        enquiry: attributes_for(:enquiry, user_id: user.id)
      }
    end

    it "returns a status code 200" do
      expect(response.status).to eq(200)
    end

    it "sends a notification to the admin" do
      expect(Notification.unread).to change by(1)
      expect(Notification.unread.sender_id).to include  user.id
    end
  end

  describe "GET #edit" do
    before do
      get :edit, params: { id: enquiry.id }
    end

    it 'renders edit template' do
      expect(response).to render_template :edit
    end

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end

  end

  describe "PUT #update" do
    before do
      put :update, params: {
        id: enquiry.id,
        enquiry: attributes_for(:enquiry, response: Faker::Lorem.sentence)
      }
    end

    it 'redirects to dashboard path' do
      expect(response).to redirect_to dashboard_path
    end

    it 'returns a 302 status' do
      expect(response.status).to eq 302
    end

    context 'when link parameters are valid' do
      it "updates the enquiry to answered" do
        expect(enquiry.reload.answered).to eq true
        expect(flash[:success]).to eq 'Response sent successfully'
      end

      it "sends a response notification to the user" do
        expect(Notification.unread(user)).to include enquiry
        expect(flash[:success]).to eq 'Response sent successfully'
      end

      it "updates notification status of admin to read" do
        expect(Notification.unread(admin)).to_not include enquiry
      end
    end

    context 'when response is not filled' do
      it 'raises an error' do
        put :update, params: {
          id: enquiry.id, enquiry: attributes_for(:enquiry, response: nil)
        }
        expect(assigns(:enquiry).errors[:response]).to include "can't be blank"
      end

      it "maintains notification status of admin to unread" do
        expect(Notification.unread(admin)).to include enquiry
      end
    end
  end
end
