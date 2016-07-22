# frozen_string_literal: true
class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :reviewer_id
      t.integer :rating
      t.string :review

      t.timestamps null: false
    end
  end
end
