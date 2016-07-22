# frozen_string_literal: true
class AddTaskeeIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :taskee_id, :integer
  end
end
