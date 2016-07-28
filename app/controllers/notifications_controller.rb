class NotificationsController < ApplicationController
  before_action :show_notification_count, only: :index
  before_action :set_notification, only: [:show, :update]

  def index
    @notifications = Notification.unread(current_user)
    Notification.update_as_notified(current_user)
  end

  def show
    @notification.update_as_read
    record = @notification.notifiable
    if request.xhr?
      render json: record
    else
      redirect_to record
    end
  end

  def update
    if request.xhr?
      set_notification_attr(params)
    else
      set_notification_attr(notification_params)
    end
    record = @notification.notifiable
    if record.update_attributes(@notifiable_attr_to_update.symbolize_keys)
      if @reply_to_sender == true
        @notification.reply_to_sender(@message, "new_task")
        @notification.update_as_read
      end
      render json: { message: "success" }
    end
  end

  private

  def notification_params
    params.require(:notification).permit!
  end

  def set_notification
    @notification = Notification.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Notification not found" }
  end

  def set_notification_attr(params)
    @notifiable_attr_to_update = params[:notifiable_attr_to_update]
    @message = params[:message]
    @reply_to_sender = params[:reply_to_sender]
  end
end
