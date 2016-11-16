class CreateServiceRatings < ActiveRecord::Migration
  def change
    create_table :service_ratings do |t|
      t.decimal :rating
      t.string :private_feedback
      t.string :public_feedback
      t.integer :type
      t.belongs_to :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
