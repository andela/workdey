class ChangeColumnNamesInTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :locaton, :location
    rename_column :tasks, :stauts, :status
  end
end
