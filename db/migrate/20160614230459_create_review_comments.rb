class CreateReviewComments < ActiveRecord::Migration
  def change
    create_table :review_comments do |t|
      t.text :body
      t.references :review, index: true, foreign_key: true
      t.references :user

      t.timestamps null: false
    end
  end
end
