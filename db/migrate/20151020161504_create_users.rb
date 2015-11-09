class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :gender
      t.date :birthday
      t.string :phone
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
