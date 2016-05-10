class TaskManagementsController < ApplicationController
  before_action :login_required, :show_notification_count,
                only: [:index, :new, :show, :review_and_rate]

  def index
    @tasks = if current_user.user_type == "tasker"
               sort_status(current_user.tasks_created)
             else
               current_user.tasks_given
             end
  end

  def new
    if params.except(:controller, :action).empty?
      redirect_to(dashboard_path) && return
    end
    @taskee_id = deobfuscate(params.except(:controller, :action))["id"]
    @taskee = User.find(@taskee_id) if @taskee_id
    @task = TaskManagement.new
  end

  def create
    @task = TaskManagement.new(task_details.except(:task_name))
    @task.task_id = Task.find_by(name: task_details[:task_name].capitalize).id
    @task.start_time = get_time(:start)
    @task.end_time = get_time(:end)
    if @task.save
      session.delete(:searcher)
      flash.clear
      flash[:notice] = "Your taskee has been notified"
      notify("taskee", @task.taskee_id)
      redirect_to dashboard_path
    else
      retain_form_values
      redirect_to assign_task_path(obfuscate(id: @task.taskee_id))
    end
  end

  def index
    all_tasks = if current_user.taskee?
                  current_user.tasks_given.order(created_at: "DESC")
                elsif current_user.tasker?
                  current_user.tasks_created.order(created_at: "DESC")
                end

    @tasks = all_tasks.all.map do |task|
      TaskManagementsPresenter.new(task)
    end
  end

  def show
  end

  def update
    id = params[:task_id]
    if TaskManagement.find(id).update_attribute(:status, "done")
      if review_and_rate(params)
        flash[:notice] = "Task is completed and your review has been recorded."
      else
        flash[:notice] = "Task is completed."
      end
    else
      flash[:alert] = "Operation failed."
    end
    redirect_to dashboard_path
  end

  def send_email_notifications(task)
    return unless current_user.enable_notifications
    notif_taskee = User.find(task.taskee_id)
    notif_tasker = User.find(task.tasker_id)
    task_category = Task.find(task.task_id)
    NotificationMailer.send_notifications(
      current_user,
      task,
      task_category,
      notif_tasker,
      notif_taskee
    ).deliver_now
  end

  private

  def task_details
    params.require(:task_management).
      permit(:task_name, :tasker_id, :taskee_id, :amount, :task_desc)
  end

  def task_date
    params.require(:date).permit(:month, :day)
  end

  def task_time
    params.require(:time_range).permit(:task)
  end

  def get_time(time_period)
    current_year = Time.now.getlocal.year
    month = task_date[:month].to_i
    day = task_date[:day].to_i

    return nil if day < Time.now.getlocal.day

    if time_period == :start
      time = parse range(task_time[:task]).first
    end

    if time_period == :end
      time = parse range(task_time[:task]).last
    end

    Time.new(current_year, month, day, time)
  end

  def range(str)
    str.gsub(/[^0-9\-(a|p)m]/, "").split("-")
  end

  def parse(str_time)
    DateTime.parse(str_time).strftime("%H").to_i
  end

  def retain_form_values
    flash[:errors] = @task.errors.full_messages
    flash[:amount] = task_details[:amount]
    flash[:task_desc] = task_details[:task_desc]
    flash[:month] = task_date[:month]
    flash[:day] = task_date[:day]
    flash[:time] = task_time[:task]
  end

  def review_and_rate(params)
    review = Review.new
    if params[:user_id] && current_user.id
      review.rating = params[:rating] if params[:rating]
      review.reviewer_id = current_user.id
      review.user_id = params[:user_id]
      review.review = params[:comment] if params[:comment]
      return "success" if review.save
    end
  end

  def sort_status(tasks)
    complete_tasks = []
    incomplete_tasks = []
    tasks.each do |task|
      task.status == "done" ? complete_tasks << task : incomplete_tasks << task
    end
    complete_tasks + incomplete_tasks.sort
  end
end
