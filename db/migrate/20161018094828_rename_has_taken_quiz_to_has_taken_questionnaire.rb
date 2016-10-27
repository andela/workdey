class RenameHasTakenQuizToHasTakenQuestionnaire < ActiveRecord::Migration
  def change
    rename_column :users, :has_taken_quiz, :has_taken_questionnaire
  end
end
