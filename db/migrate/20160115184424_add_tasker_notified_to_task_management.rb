class AddTaskerNotifiedToTaskManagement < ActiveRecord::Migration
  def change
    add_column :task_managements, :tasker_notified, :boolean, default: false
  end
end
