class SkillsetsController < ApplicationController
  before_action :taskee_required

  def index
    @skillsets = current_user.tasks
  end

  def create
    @task = Task.find_or_create_by(name: task_params[:name])
    @skillset = Skillset.find_or_create_by(
      user_id: current_user.id,
      task_id: @task.id
    ) { |skillset| skillset.was_created = true }
    respond_to :js
  end

  def destroy
    @skillset = current_user.skillsets.detect do |skillset|
      skillset.task_id == params[:task_id].to_i
    end.destroy
    respond_to :js
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end
end
