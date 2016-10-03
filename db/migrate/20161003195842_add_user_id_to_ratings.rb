class AddUserIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :user_id, :integer
  end
end
