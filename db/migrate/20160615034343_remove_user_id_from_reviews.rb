class RemoveUserIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :user_id
    add_column :reviews, :reviewee_id, :integer
  end
end
