class CreateUserPlans < ActiveRecord::Migration
  def change
    create_table :user_plans do |t|
      t.string :plan
      t.date :active_until
      t.integer :user_id
      t.integer :tasks_counter, default: 0

      t.timestamps null: false
    end
  end
end
