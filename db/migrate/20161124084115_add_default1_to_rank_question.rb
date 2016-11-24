class AddDefault1ToRankQuestion < ActiveRecord::Migration
  def change
    change_column :questions, :rank, :integer, default: 1
  end
end
