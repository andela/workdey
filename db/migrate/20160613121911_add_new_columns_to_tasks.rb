class AddNewColumnsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :price, :integer
    add_column :tasks, :time, :string
    add_column :tasks, :start_date, :datetime
    add_column :tasks, :end_date, :datetime
    add_column :tasks, :tasker_id, :integer
    add_column :tasks, :taskee_id, :integer
    add_column :tasks, :locaton, :string
    add_column :tasks, :stauts, :string
  end
end
