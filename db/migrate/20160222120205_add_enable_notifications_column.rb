class AddEnableNotificationsColumn < ActiveRecord::Migration
  def change
<<<<<<< HEAD
    add_column :users, :enable_notifications, :boolean, default: true
=======
    add_column :users, :enable_notifications, :boolean,  default: true
>>>>>>> ebdc59d... added migration for notifications
  end
end
