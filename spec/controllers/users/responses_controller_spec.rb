require "rails_helper"

describe Users::ResponsesController do

  describe 'GET #new' do

    context "when user is logged in but has not taken questionnaire" do
      let(:user) { create(:user, user_type: "artisan", has_taken_questionnaire: false) }
      before do
        get :new
      end
      it { should respond_with :ok }
      it { should render_with_layout :application }
      it { should render_template :new }
    end

  end

  describe "GET #show" do

    context "when viewing questionnaire" do
      let(:user) { create(:user, user_type: "artisan", has_taken_questionnaire: false) }
      before(:each) { stub_current_user(user) }

      let!(:req) do
        get :show, id: user.id
      end

      it { should respond_with :ok }
      it { should render_with_layout :application }
      it { should render_template :show }
    end

  end

end
