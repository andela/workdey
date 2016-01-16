class NotificationsController < ApplicationController
  before_action :show_notification_count, only: :index

  def index
    if current_user.user_type == "taskee" then taskee_notifications end
    if current_user.user_type == "tasker" then tasker_notifications end
  end

  def show
    request = TaskManagement.find params[:id]
    request.update_attribute(:viewed, true)
    title = params[:title]
    description = request.task_desc
    date = pad_date(request.start_time.strftime("%B %e")) << " of this year"
    time = format_for_view(request.start_time, request.end_time)
    amount = request.amount

    render json: {
      title: title,
      description: description,
      date: date,
      time: time,
      amount: amount
    }
  end

  def update
    record = TaskManagement.find params[:id]
    if record.update_attribute(:status, params[:status])
      render json: { message: "success" }
    end
  end

  private

  def notifications_for_taskee
    @notifications ||= TaskManagement.where(taskee_id: current_user.id, status: "inactive")
                    .order(viewed: :asc, created_at: :desc)
                    .select(:id, :task_id, :tasker_id, :viewed)
  end

  def notifications_for_tasker
  end

  def taskee_notifications
    all_notifications_seen_for(current_user)
    notifications_for_taskee
  end

  def tasker_notifications
    all_notifications_seen_for(current_user)
    notifications_for_tasker
  end

  def all_notifications_seen_for(user)
    query = user.user_type == "tasker" ? "tasker_id" : "taskee_id"
    attribute = user.user_type == "tasker" ? "tasker_notified" : "taskee_notified"
    TaskManagement.where(query => user.id).each do |obj|
      obj.update_attribute(attribute, true) unless obj[attribute]
    end
  end

  def pad_date(date_str)
    pad_with = ""
    date_num = date_str.split(" ").find { |v| v.match /[0-9]/ }[-1].to_i

    case
    when date_num == 1
      pad_with = "st"
    when date_num == 2
      pad_with = "nd"
    when date_num == 3
      pad_with = "rd"
    else
      pad = "th"
    end

    date_str << pad
  end

  def format_for_view(start_time, end_time)
    start_time = (start_time + 3600).strftime("%l%P").strip
    end_time = (end_time + 3600).strftime("%l%P").strip
    time_range = "(#{start_time} - #{end_time})"

    case
    when time_range.gsub(/[\(\)]/, "") == "8am - 8pm"
      "Anytime " << time_range
    when time_range.gsub(/[\(\)]/, "") == "8am - 12pm"
      "Morning " << time_range
    when time_range.gsub(/[\(\)]/, "") == "12pm - 4pm"
      "Afternoon " << time_range
    when time_range.gsub(/[\(\)]/, "") == "4pm - 8pm"
      "Evening " << time_range
    end
  end
end
