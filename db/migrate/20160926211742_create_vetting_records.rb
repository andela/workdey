class CreateVettingRecords < ActiveRecord::Migration
  def change
    create_table :vetting_records do |t|
      t.integer :user_id
      t.integer :confidence
      t.integer :skill_proficiency
      t.integer :experience
      t.integer :interviewer_verdict
      t.text :interviewer_comments

      t.timestamps null: false
    end
  end
end
