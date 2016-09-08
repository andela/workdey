# frozen_string_literal: true
class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :description
      t.text :price_range
      t.date :start_date
      t.date :end_date
      t.references :task, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
