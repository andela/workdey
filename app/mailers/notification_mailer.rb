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

  def send_broadcast_mail(tasker, taskee, task)
    @tasker = tasker
    @taskee = taskee
    @task = task
    mail(
      to: @taskee.email,
      subject: "Available Tasks that matches your skillset"
    )
  end

  def send_contact_info(tasker, taskee)
    @tasker = tasker
    @taskee = taskee
    @fullname = taskee.fullname
    mail to: tasker.email, subject: "#{@fullname} has shared contact with you"
  end
end
