# frozen_string_literal: true
class NotificationMailer < ApplicationMailer
  def send_notifications(
    user,
    task,
    task_category,
    notification_taskee,
    notification_tasker
  )
    @user = user
    @task = task
    @task_category = task_category
    @taskee = notification_taskee
    @tasker = notification_tasker
    mail to: @taskee.email, subject: "You have notifications on Workdey"
  end
end
