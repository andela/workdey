class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  def update_as_viewed
    update_attribute(:read, true)
  end

  def self.unseen(user)
    user.notifications.where(user_notified: false)
  end

  def self.unread(user)
    user.notifications.where(read: false)
  end

  def self.update_as_notified(user)
    user.notifications.where(user_notified: false).
      update_all(user_notified: true)
  end

  def self.notify(user_id, event_name)
    unnotified_count =
      where(receiver_id: user_id).where(user_notified: false).count

    WebsocketRails.users[user_id].send_message(
      event_name.to_sym,
      unnotified_count
    )
  end
end
