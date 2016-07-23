# frozen_string_literal: true
class AddBroadcastedToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :broadcasted, :boolean, default: false
  end
end
