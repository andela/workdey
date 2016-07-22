# frozen_string_literal: true
class AddEnableNotificationsColumn < ActiveRecord::Migration
  def change
    add_column :users, :enable_notifications, :boolean, default: true
  end
end
