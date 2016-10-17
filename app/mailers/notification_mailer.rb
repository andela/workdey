# frozen_string_literal: true
class NotificationMailer < ApplicationMailer
  def send_notifications(
    user,
    task,
    task_category,
    notification_artisan,
    notification_tasker
  )
    @user = user
    @task = task
    @task_category = task_category
    @artisan = notification_artisan
    @tasker = notification_tasker
    mail to: @artisan.email, subject: "You have notifications on Workdey"
  end

  def send_contact_info(tasker, artisan)
    @tasker = tasker
    @artisan = artisan
    @fullname = artisan.fullname
    mail to: tasker.email, subject: "#{@fullname} has shared contact with you"
  end
end
