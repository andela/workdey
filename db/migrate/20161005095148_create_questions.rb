class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question
      t.boolean :required
      t.string :options, array: true, default: []
      t.boolean :radio

      t.timestamps null: false
    end
  end
end
