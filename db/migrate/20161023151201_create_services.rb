class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :tasker_id, index: true
      t.integer :artisan_id, index: true
      t.belongs_to :skillset, index: true, foreign_key: true
      t.string :title
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :duration
      t.boolean :is_assigned

      t.timestamps null: false
    end
  end
end
