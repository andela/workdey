class TasksController < ApplicationController
  def new
    @task = Task.new
    @skillsets = Skillset.all.select(&:name)
  end

  def create
    binding.pry
    @task = Task.new(task_params)
    if @task.save
      redirect_to dashboard_path, notice: "You need has been created"
    else
      @skillsets = Skillset.all.select(&:name)
      render "new"
    end
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
      :skillset_id
    ).merge(tasker_id: current_user.id)
  end
end
