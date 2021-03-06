class TasksController < ApplicationController
  before_action :login_required
  before_action :set_task, except: [:new, :create, :search]
  before_action :set_skillsets, only: [:new, :edit, :update, :create]

  def new
    @task = Task.new
  end

  def edit
    render "new"
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Your task has been successfully updated"
    else
      render "new"
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "Your task has been created"
    else
      render "new"
    end
  end

  def close_bid
    @task.update(broadcasted: false)
    redirect_to @task, notice: "Bids successfully closed"
  end

  def search
    search_tasks = Task.search_for_available_need(params[:need])
    @tasks = search_tasks ? paginate_tasks(search_tasks) : []
  end

  def broadcast_task
    if @task.update(broadcasted: true)
      create_task_notification(@task)
      update_redirect("Available Artisans have been notified")
    else
      render "show"
    end
  end

  def destroy
    @task.destroy
    redirect_to my_tasks_path
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
      :latitude,
      :min_price,
      :max_price
    ).merge(
      tasker_id: current_user.id,
      price_range: [params[:task][:min_price], params[:task][:max_price]]
    )
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_skillsets
    @skillsets = Skillset.all.select(&:name)
  end

  def available_artisans(skillset)
    User.get_artisans_by_skillset(skillset)
  end

  def create_task_notification(task)
    available_artisans(task.skillset.name).map do |artisan|
      Notification.create(
        message: "New Task available that matches your skillset.",
        sender_id: task.tasker_id,
        receiver_id: artisan.id,
        notifiable: task
      ).notify_receiver("broadcast_task")
    end
  end

  def paginate_tasks(tasks)
    tasks.paginate(page: params[:page], per_page: 9)
  end

  def update_redirect(message)
    redirect_to @task, notice: message
  end
end
