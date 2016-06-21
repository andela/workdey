class AddSkillsetsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :skillsets, :string
  end
end
