class AddHasTakenQuizToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_taken_quiz, :boolean, default: false
  end
end
