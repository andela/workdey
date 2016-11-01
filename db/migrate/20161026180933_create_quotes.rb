class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :artisan_id
      t.integer :service_id
      t.integer :quoted_value
      t.integer :status

      t.timestamps null: false
    end
  end
end
