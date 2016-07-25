# frozen_string_literal: true
class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message
      t.boolean :read, default: :false
      t.integer :sender_id, index: true
      t.integer :receiver_id, index: true

      t.timestamps null: false
    end
  end
end
