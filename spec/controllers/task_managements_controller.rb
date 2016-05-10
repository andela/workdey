require "rails_helper"

RSpec.describe TaskManagementsController, type: :controller do
  let(:curr_user) { create(:user) }

  subject(:user) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)
  end

  subject(:user_nil) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(nil)
  end

  describe "#index method" do
    context "Anonymous user visiting the task logs page" do
      before { user_nil }

      it "should redirect anonymous user" do
        get :index

        expect(response).to have_http_status(302)
      end
    end

    context "Registered user visiting the tasks logs page" do
      before { user }

      it "should be able to access task logs page" do
        get :index

        expect(response).to have_http_status(200)
        expect(response).to render_template("index")
      end
    end
  end
end
