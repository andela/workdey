class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :question
      t.string :response
      t.boolean :answered, default: :false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
