class AddSkillsetRefToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :skillset, index: true, foreign_key: true
  end
end
