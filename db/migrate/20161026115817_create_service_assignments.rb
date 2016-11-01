class CreateServiceAssignments < ActiveRecord::Migration
  def change
    create_table :service_assignments do |t|
      t.belongs_to :service, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.boolean :accepted, default: false

      t.timestamps null: false
    end
  end
end
