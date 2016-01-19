class TaskmanagementsController < ApplicationController
  before_action :show_notification_count, only: :new

  def new
    if params.except(:controller, :action).empty?
      redirect_to(dashboard_path) && return
    end

    @taskee_id = deobfuscate(params.except(:controller, :action))["id"]
    @taskee = User.find @taskee_id if @taskee_id
    @task = TaskManagement.new
  end

  def create
    @task = TaskManagement.new
    @task.task_id = Task.find_by(name: task_details[:task_name].capitalize).id
    @task.tasker_id = task_details[:tasker_id].to_i
    @task.taskee_id = task_details[:taskee_id].to_i
    @task.amount = task_details[:amount].to_i
    @task.task_desc = task_details[:task_desc]
    @task.start_time = get_time(:start)
    @task.end_time = get_time(:end)

    if @task.save
      session.delete(:searcher)
      notify_taskee(@task.taskee_id)
      redirect_to dashboard_path
    else
      flash[:errors] = @task.errors.full_messages
      flash[:amount] = task_details[:amount]
      flash[:task_desc] = task_details[:task_desc]
      flash[:month] = task_date[:month]
      flash[:day] = task_date[:day]
      flash[:time] = task_time[:task]
      redirect_to assign_task_path(obfuscate(id: @task.taskee_id))
    end
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
end
