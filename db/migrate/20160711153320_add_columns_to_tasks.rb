class AddColumnsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :description, :string
    add_column :tasks, :price, :integer
    add_column :tasks, :time, :time
    add_column :tasks, :start_date, :date
    add_column :tasks, :end_date, :date
    add_column :tasks, :tasker_id, :integer
    add_column :tasks, :location, :string
    add_column :tasks, :status, :string
  end
end
