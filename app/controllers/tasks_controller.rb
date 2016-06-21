class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params.except(:type).merge(tasker_id: current_user.id))
    if task.save
      if task_params[:type] == "assign"
        @taskees = Skillset.get_taskees(task[:skillsets])
        street_address, city = task[:location].split(",")
        @taskees = Task.get_taskees_nearby(
          @taskees,
          street_address.strip.downcase,
          city.strip.downcase
        ) unless task[:location].empty?
        render "partials/search_result", locals: { task_id: task.id, assigns: true }
      end
    end
  end

  def view_taskee
    taskee_id = params[:taskee_id]
    @user = User.find(taskee_id)
    render 'partials/profile_view', locals: { assign: true, task_id: params[:task_id] }
  end

  def assign
    task = Task.find(params[:task_id])
    task.update_attributes(taskee_id: params[:id], status: "assigned")
    redirect_to dashboard_path, notice: "You have assigned the task to a Taskee"
  end
  private

  def task_params
    params.require(:task).permit(
      :name,
      :price,
      :start_date,
      :end_date,
      :time,
      :location,
      :description,
      :skillsets,
      :type
    )
  end
end
