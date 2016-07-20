require "rails_helper"

RSpec.describe Dashboard::EndorsementsController, type: :controller do
  let(:user) { create(:user) }
  let(:reference) do
    create(:reference, taskee_id: user.id,
                       skillsets: { "skills" => %w(Plumbing Carpentry) })
  end

  before do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
  end

  describe "GET #new" do
    let!(:req) { get :new, t: reference.confirmation_token }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "assigns taskee firstname to @taskee" do
      expect(assigns(:taskee)).to eq(user.firstname)
    end
    it "assigns taskee's skillset to @taskee_skillsets" do
      expect(assigns(:taskee_skillsets)).to eql(%w(Plumbing Carpentry))
    end
  end

  describe "POST create" do
    let!(:req) do
      post :create,
           t: reference.confirmation_token,
           relationship: "Professional: I have worked with Ruth",
           recommendation: "Ruth is great"
    end

    subject(:endorsed) { assigns(:reference) }

    it "sets @reference as done" do
      expect(endorsed.done).to be true
    end

    it "adds endorsement" do
      expect(endorsed.skillsets[:endorsement][0]).to match(/Ruth is great/)
      expect(endorsed.skillsets[:endorsement][1]).
        to match(/Professional: I have worked with Ruth/)
    end

    it "redirects to root path" do
      expect(response).to redirect_to(root_path)
    end
  end
end
