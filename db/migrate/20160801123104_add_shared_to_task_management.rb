class AddSharedToTaskManagement < ActiveRecord::Migration
  def change
    add_column :task_managements, :shared, :boolean, default: false
  end
end
