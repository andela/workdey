class CreateServiceAssignments < ActiveRecord::Migration
  def change
    create_table :service_assignments do |t|
      t.integer :service_id
      t.integer :artisan_id
      t.boolean :accepted, default: false

      t.timestamps null: false
    end
  end
end
