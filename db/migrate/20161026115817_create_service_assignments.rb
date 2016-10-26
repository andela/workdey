class CreateServiceAssignments < ActiveRecord::Migration
  def change
    create_table :service_assignments do |t|

      t.timestamps null: false
    end
  end
end
