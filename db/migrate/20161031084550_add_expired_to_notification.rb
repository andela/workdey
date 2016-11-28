class AddExpiredToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :expired, :boolean, default: false
  end
end
