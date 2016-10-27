class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  def self.unnotified(user)
    user.notifications.where(user_notified: false)
  end

  def self.unnotified_count(user_id)
    where(receiver_id: user_id).where(user_notified: false).count
  end

  def self.unread(user)
    user.notifications.where(read: false)
  end

  def self.update_as_notified(user)
    user.notifications.where(user_notified: false).
      update_all(user_notified: true)
  end

  def self.responded_enquiry(enquiry)
    return unless Notification.receiver.admin?
      .where(notifiable_type: "Enquiry")
        .where(notifiable_id: enquiry.id).each do |notification|
          notification.update_attributes(read: true, user_notified: true)
    end
  end

  def update_as_read
    update_attribute(:read, true)
  end

  def reply_to_sender(message, event_name)
    Notification.create(
      message: message,
      receiver_id: sender_id,
      sender_id: receiver_id,
      notifiable: notifiable
    ).notify_receiver(event_name)
  end

  def notify_sender(event_name)
    send_message(sender_id, event_name)
  end

  def notify_receiver(event_name)
    send_message(receiver_id, event_name)
  end

  def send_message(user_id, event_name)
    WebsocketRails.users[user_id].send_message(
      event_name.to_sym,
      Notification.unnotified_count(user_id)
    )
  end
end
