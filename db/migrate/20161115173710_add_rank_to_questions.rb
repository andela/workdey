class AddRankToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :rank, :integer
  end
end
