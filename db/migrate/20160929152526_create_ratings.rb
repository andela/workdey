class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :comment
      t.integer :rating

      t.timestamps null: false
    end
  end
end
