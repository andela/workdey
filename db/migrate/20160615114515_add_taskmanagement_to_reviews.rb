class AddTaskmanagementToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :task_management, index: true, foreign_key: true
  end
end
