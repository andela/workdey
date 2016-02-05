class AddToggleNotificationsToUserTable < ActiveRecord::Migration
  def change
  	add_column :users, :enable_notifications, :boolean, default: false
  end
end
