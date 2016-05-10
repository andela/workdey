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
      skillsets = @user.tasks
      expect(assigns(:skillsets)).to eq(skillsets)
    end
  end

  describe 'POST #create' do
    before(:each) { @task_count = Task.count }

    context 'when the task exists' do
      it 'should find a task' do
        task = Task.first
        post :create, { task: { name: task.name }, format: :js }
        expect(assigns(:skillset).task_id).to eq(task.id)
        expect(Task.count).to eq(@task_count)
      end
    end

    context 'when the task does not exist' do
      it 'should create a task' do
        task = create(:task, name: 'Cleaning')
        post :create, { task: { name: task.name }, format: :js }
        expect(assigns(:skillset).task_id).to eq(task.id)
        expect(Task.count).to eq(@task_count + 1)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete a skillset' do
      task = create(:task, name: 'Cleaning')
      skillset = create(:skillset, task_id: task.id, user_id: @user.id)
      expect {
        delete :destroy, { task_id: task.id, format: :js }
      }.to change(Skillset, :count).by(-1)
    end
  end
end
