class AddStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer
  end
end
