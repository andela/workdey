class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :artisan_id, index: true, foreign_key: true
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :relationship

      t.timestamps null: false
    end
  end
end
