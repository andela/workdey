# frozen_string_literal: true
class CreateSkillsets < ActiveRecord::Migration
  def change
    create_table :skillsets do |t|
      t.integer :user_id
      t.integer :task_id
      t.string :rate

      t.timestamps null: false
    end
  end
end
