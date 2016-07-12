require "rails_helper"

RSpec.describe SkillsetsController, type: :controller do
  before(:each) do
    user_attr = { user_type: "taskee", has_taken_quiz: true }
    @user = create(:user_with_tasks, user_attr)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  describe 'GET #index' do
    before(:each) { get :index }

    it "renders the index template" do
      expect(response).to render_template(:index)
    end

    it "return a status code of 200" do
      expect(response.status).to eq(200)
    end

    it "assigns current_user skillset to @skillset" do
      skillsets = @user.skillsets
      expect(assigns(:skillsets)).to eq(skillsets)
    end
  end

  describe 'POST #create' do
    before do
      # @task = create(:task)
      @skillset = create(:skillset, user_id: @user.id)
      @skillset_count = Skillset.count
    end

    context "when the skillset exists" do
      it "should find a skillset" do
        post :create, skillset: { name: @skillset.name }, format: :js
        expect(assigns(:skillset).id).to eq(@skillset.id)
        expect(Skillset.count).to eq(@skillset_count)
      end
    end

    context "when the skillset does not exist" do
      it "should create a skillset" do
        post :create, skillset: { name: Faker::Name.name }, format: :js
        expect(Skillset.count).to eq(@skillset_count + 1)
      end
    end
  end

  describe 'DELETE #destroy' do
    it "should delete a skillset" do
      # task = create(:task, name: Faker::Lorem.word)
      skillset = create(:skillset, user_id: @user.id)
      expect do
        delete :destroy, skillset_id: skillset.id, format: :js
      end.to change(Skillset, :count).by(-1)
    end
  end
end
