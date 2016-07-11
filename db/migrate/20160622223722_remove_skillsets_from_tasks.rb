class RemoveSkillsetsFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :skillsets
  end
end
