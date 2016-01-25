class AddColumnsToTaskManagement < ActiveRecord::Migration
  def change
    add_column :task_managements, :status, :string, default: "inactive"
    add_column :task_managements, :notified, :boolean, default: false
    add_column :task_managements, :viewed, :boolean, default: false
  end
end
