class RemoveColumnsFromSkillsets < ActiveRecord::Migration
  def change
    remove_column :skillsets, :user_id, :integer
    remove_column :skillsets, :task_id, :integer
  end
end
