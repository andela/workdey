class CreateTaskManagements < ActiveRecord::Migration
  def change
    create_table :task_managements do |t|
      t.integer :task_id
      t.integer :tasker_id
      t.integer :artisan_id
      t.string :task_desc

      t.timestamps null: false
    end
  end
end
