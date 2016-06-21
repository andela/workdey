class NotificationsController < ApplicationController
  before_action :show_notification_count, only: :index

  def index
    @notifications = Notification.unread(current_user)
    Notification.update_as_notified(current_user)
  end

end
