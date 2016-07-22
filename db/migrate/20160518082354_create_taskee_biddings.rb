# frozen_string_literal: true
class CreateTaskeeBiddings < ActiveRecord::Migration
  def change
    create_table :taskee_biddings do |t|
      t.references :bidding, index: true, foreign_key: true
      t.integer :taskee_id

      t.timestamps null: false
    end
  end
end
