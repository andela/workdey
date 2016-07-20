class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @skillsets = Skillset.all.select(&:name)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "Your need has been created"
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
      :skillset_id,
      :longitude,
      :latitude
    ).merge(tasker_id: current_user.id)
  end
end
