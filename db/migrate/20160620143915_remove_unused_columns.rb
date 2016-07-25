# frozen_string_literal: true
class RemoveUnusedColumns < ActiveRecord::Migration
  def change
    remove_column :task_managements, :taskee_notified
    remove_column :task_managements, :tasker_notified
    remove_column :task_managements, :viewed
    remove_column :notifications, :viewed
  end
end
