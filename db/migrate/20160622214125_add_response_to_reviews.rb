class AddResponseToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :response, :text
  end
end
