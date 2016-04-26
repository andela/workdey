class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks
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
    @skillset = Skillset.find_by(user_id: current_user.id, task_id: params[:id])
    @skillset.destroy
    respond_to :js
  end

  private
    def task_params
      params.require(:task).permit(:name)
    end
end
