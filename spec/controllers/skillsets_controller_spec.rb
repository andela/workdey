require 'rails_helper'

RSpec.describe SkillsetsController, type: :controller do
  before(:each) do
    user_attr = { user_type: 'taskee', has_taken_quiz: true }
    @user = create(:user_with_tasks, user_attr)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  describe 'GET #index' do
    before(:each) { get :index }

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'return a status code of 200' do
      expect(response.status).to eq(200)
    end

    it 'assigns current_user skillset to @skillset' do
      skillsets = @user.tasks
      expect(assigns(:skillsets)).to eq(skillsets)
    end

  end

end
