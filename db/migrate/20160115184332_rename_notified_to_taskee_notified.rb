# frozen_string_literal: true
class RenameNotifiedToTaskeeNotified < ActiveRecord::Migration
  def change
    rename_column :task_managements, :notified, :taskee_notified
  end
end
