class AddColumnToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :user_notified, :boolean, default: :false
    add_column :notifications, :viewed, :boolean, default: false
    add_column :notifications, :notifiable_id, :integer
    add_column :notifications, :notifiable_type, :string

    add_index :notifications, :notifiable_id
  end
end
