class NotificationsController < ApplicationController
  before_action :show_notification_count, only: :index

  def index
    @notifications = Notification.unread(current_user)
    Notification.update_as_notified(current_user)
  end

  def show_task_management_notification
    notification = Notification.find(params[:id])
    notification.update_as_viewed
    request = TaskManagement.find(notification.notifiable_id)
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

  def update_task_management_notification
    notification = Notification.find(params[:id])
    record = TaskManagement.find(notification.notifiable_id)
    if record.update_attribute(:status, params[:status])
      taskee_response = record.status == "active" ? "accepted" : "rejected"
      Notification.create(
        message: "#{record.taskee.firstname} #{taskee_response} your task.",
        sender_id: record.taskee_id,
        receiver_id: record.tasker_id,
        notifiable: record
      ).update_as_viewed
      Notification.notify(record.tasker_id, "new_task")
      render json: { message: "success" }
    end
  end

  private

  def pad_date(date_str)
    date_num = date_str.split(" ").detect { |v| v.match(/[0-9]/) }[-1].to_i
    date_str << pad_with(date_num)
  end

  def pad_with(date_num)
    return "st" if date_num == 1
    return "nd" if date_num == 2
    return "rd" if date_num == 3
    "th"
  end

  def format_for_view(start_time, end_time)
    start_time = (start_time + 3600).strftime("%l%P").strip
    end_time = (end_time + 3600).strftime("%l%P").strip
    time_range = "#{start_time} - #{end_time}"
    "#{day_period(time_range)} (#{time_range})"
  end

  def day_period(time_range)
    return "Anytime" if time_range == "8am - 8pm"
    return "Morning" if time_range == "8am - 12pm"
    return "Afternoon" if time_range == "12pm - 4pm"
    "Evening" if time_range == "4pm - 8pm"
  end
end
