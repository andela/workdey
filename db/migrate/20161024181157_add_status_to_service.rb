class AddStatusToService < ActiveRecord::Migration
  def change
    add_column :services, :status, :integer
  end
end
