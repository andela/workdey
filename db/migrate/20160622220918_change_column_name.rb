class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :reviews, :review, :body
    drop_table :review_comments
  end
end
