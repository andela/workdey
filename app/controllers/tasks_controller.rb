class TasksController < ApplicationController
  def new
    @task = Task.new
    @skillsets = Skillset.all.select(&:name)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to dashboard_path, notice: "Your need has been created"
    else
      @skillsets = Skillset.all.select(&:name)
      render "new"
    end
  end

  def search
    search_tasks = Task.search_for_available_need(params[:need])
    @tasks = search_tasks ? paginate_tasks(search_tasks) : []
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

  def paginate_tasks(tasks)
    tasks.paginate(page: params[:page], per_page: 9)
  end
end
