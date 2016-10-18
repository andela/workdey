# frozen_string_literal: true
class AddArtisanIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :artisan_id, :integer
  end
end
