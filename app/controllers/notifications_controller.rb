class NotificationsController < ApplicationController
  before_action :show_notification_count, only: :index
  before_action :set_notification, only: [:show, :update]
  before_action :set_expiration, only: :show
  NOTIFICATION_EXPIRATION_TIME = 30.minutes

  def index
    @notifications = Notification.unread(current_user)
    Notification.update_as_notified(current_user)
  end

  def show
    @notification.update_as_read
    record = @notification.notifiable.as_json
    record["expired"] = @notification.expired
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
      @notification.update_as_read force_update: true
      if @reply_to_sender == true
        @notification.reply_to_sender(@message, "new_task")
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

  def set_expiration
    if (Time.now - @notification.created_at) > NOTIFICATION_EXPIRATION_TIME
      @notification.update(expired: true)
    end
  end
end
