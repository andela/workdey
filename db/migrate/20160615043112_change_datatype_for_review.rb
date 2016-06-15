class ChangeDatatypeForReview < ActiveRecord::Migration
  def up
    change_column :reviews, :review, :text
  end

  def down
    change_column :reviews, :review, :string
  end
end
