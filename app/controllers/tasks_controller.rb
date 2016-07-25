# frozen_string_literal: true
class TasksController < ApplicationController
  before_action :set_task, only: [:update, :show, :close_bid]
  before_action :validate_pricerange, only: :update

  def new
    @task = Task.new
    @skillsets = Skillset.all.select(&:name)
  end

  def update
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

  def close_bid
    @task.update(broadcasted: false)
    redirect_to @task, notice: "Bids successfully closed"
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
      :skillset_id,
      :longitude,
      :latitude,
      :min_price,
      :max_price
    ).merge(tasker_id: current_user.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def available_taskees(skillset)
    User.get_taskees_by_skillset(skillset)
  end

  def create_task_notification(task)
    available_taskees(task.skillset.name).map do |taskee|
      Notification.create(
        message: "New Task available that matches your skillset.",
        sender_id: task.tasker_id,
        receiver_id: taskee.id,
        notifiable: task
      ).notify_receiver("broadcast_task")
    end
  end

  def paginate_tasks(tasks)
    tasks.paginate(page: params[:page], per_page: 9)
  end

  def price_range
    [params[:min_price], params[:max_price]]
  end

  def update_redirect(message)
    redirect_to @task, notice: message
  end

  def validate_pricerange
    if price_range.first > price_range.last
      update_redirect("Minimum price must be less than the maximum")
    elsif (price_range.first.to_i || price_range.last.to_i) < 2000
      update_redirect("Prices must be more than 2000")
    elsif @task.update(price_range: price_range, broadcasted: true)
      create_task_notification(@task)
      update_redirect("Available Taskees have been notified")
    else
      render "show"
    end
  end
end
