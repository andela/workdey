class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.jsonb :response
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
