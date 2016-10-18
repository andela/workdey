require "rails_helper"

describe Users::ResponsesController do

  describe 'GET #new' do

    context "when user is logged in but has not taken questionnaire" do
      let(:user) { create(:user, user_type: "taskee", has_taken_quiz: false) }
      before do
        get :new
      end
      it { should respond_with :ok }
      it { should render_with_layout :application }
      it { should render_template :new }
    end

  end

  describe "POST #create" do

    let(:user) { create(:user, user_type: nil, has_taken_quiz: false) }
    before(:each) { stub_current_user(user) }

    let!(:req) do
       post :create,
         response: {
          response: Faker::Lorem.paragraph
         }
    end

    context "saving response" do
      it { should respond_with :ok }
      it { should render_with_layout :application }
    end
  end

  describe "GET #show" do

    context "when viewing questionnaire" do
      let(:user) { create(:user, user_type: "taskee", has_taken_quiz: false) }
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
