class CreateSkillsetsTasks < ActiveRecord::Migration
  def change
    create_table :skillsets_tasks, id: false do |t|
      t.integer :skillset_id
      t.integer :task_id
    end
  end
end
