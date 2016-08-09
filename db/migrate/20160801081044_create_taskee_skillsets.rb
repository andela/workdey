class CreateTaskeeSkillsets < ActiveRecord::Migration
  def change
    create_table :taskee_skillsets do |t|
      t.references :skillset, index: true, foreign_key: true
      t.integer :taskee_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
