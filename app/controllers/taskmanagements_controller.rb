class TaskmanagementsController < ApplicationController
  before_action :check_plan, only: :create
  before_action :show_notification_count, only: :new

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
      notify("taskee", @task.taskee_id)
      redirect_to dashboard_path
    else
      retain_form_values
      redirect_to assign_task_path(obfuscate(id: @task.taskee_id))
    end
  end

  def send_email_notifications(task)
    notif_taskee = User.find_by_id(task.taskee_id)
    notif_tasker = User.find_by_id(task.tasker_id)
    task_category = Task.find_by_id(task.task_id)
    @notif = current_user.enable_notifications
    NotificationMailer.send_notifications(
      current_user,
      task,
      task_category,
      notif_tasker,
      notif_taskee
    ).deliver_now if @notif == true
  end

  private

  def check_plan(task_details[:tasker_id])
    tasker_plan_status = User.check_plan_and_status(task_details[:tasker_id])
    tasker_expiry_date = tasker_plan_status[1]
    tasker_plan = tasker_plan_status[0]
    if tasker_expiry_date > Time.now
      task_created = User.find(task_details[:tasker_id]).task_created.count
      if task_created == no_of_tasks(tasker_plan)
        redirect_to user_plans_path, notice: "You have maxed out you current subscription, subscribe to your current plan or choose a different plan!!"
      end
    else
      redirect_to dashboard_path, notice: "Your subscription has expired. subscribe and try again"
    end
  end

  def no_of_tasks(tasker_plan)
    case tasker_plan
    when "novice" then no_of_permitted_task[:novice]
    when "medial" then no_of_permitted_task[:medial]
    else no_of_permitted_task[:maestro]
    end
  end

  def no_of_permitted_task
    {
      novice: 10,
      medial: 50,
      maestro: Float::INFINITY
    }
  end

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
end
