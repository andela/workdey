class CreateVettingRecords < ActiveRecord::Migration
  def change
    create_table :vetting_records do |t|
      t.integer :confidence
      t.integer :skill_proficiency
      t.integer :experience
      t.string :interviewer_comment
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
