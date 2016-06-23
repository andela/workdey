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
      @task = create(:task, task_attr)
      @skillset = create(:skillset, task_id: @task.id, user_id: @user.id)
      @skillset_count = Skillset.count
    end

    context "when the skillset exists" do
      it "should find a skillset" do
        post :create, skillset: { name: @skillset.name }, format: :js
        expect(assigns(:skillset).task_id).to eq(@task.id)
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
      task = create(:task, task_attr.merge(name: Faker::Lorem.word))
      create(:skillset, task_id: task.id, user_id: @user.id)
      expect do
        delete :destroy, task_id: task.id, format: :js
      end.to change(Skillset, :count).by(-1)
    end
  end

  describe "GET #search_skillset" do
    before(:each) do
      @skillset = create(:skillset)
    end
    context "when the right query is passed to the controller" do
      it "returns the correct skillset" do
        get :search_skillsets, query: @skillset.name.to_s, format: :json
        result = JSON.parse(response.body)
        expect(result.first["name"]).to eq @skillset.name
      end
    end

    context "when a query that doesn't have result is passed" do
      it "returns an empty array" do
        get :search_skillsets, query: Faker::Lorem.word, format: :json
        result = JSON.parse(response.body)
        expect(result).to eq []
      end
    end
  end
end
