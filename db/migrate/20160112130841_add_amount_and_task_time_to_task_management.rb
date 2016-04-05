class AddAmountAndTaskTimeToTaskManagement < ActiveRecord::Migration
  def change
    add_column :task_managements, :amount, :integer
    add_column :task_managements, :start_time, :datetime
    add_column :task_managements, :end_time, :datetime
  end
end
