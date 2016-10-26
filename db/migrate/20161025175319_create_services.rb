class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :tasker_id
      t.integer :artisan_id
      t.integer :skillset_id
      t.string :title
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :duration
      t.integer :status

      t.timestamps null: false
    end
  end
end
