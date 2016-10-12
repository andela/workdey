# frozen_string_literal: true
class RenameNotifiedToArtisanNotified < ActiveRecord::Migration
  def change
    rename_column :task_managements, :notified, :artisan_notified
  end
end
