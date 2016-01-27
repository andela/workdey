# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def send_notifications
    NotificationMailer.send_notifications(user, 
    											task, 
    											task_category, 
    											notification_taskee, 
    											notification_tasker)
  end
end
