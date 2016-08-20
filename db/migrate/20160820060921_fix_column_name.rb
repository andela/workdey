class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :task_managements, :task_desc, :description
  end
end
