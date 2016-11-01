class RemoveIsAssignedFromService < ActiveRecord::Migration
  def change
    remove_column :services, :is_assigned
  end
end
