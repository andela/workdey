class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :user_plan, :string
    remove_column :users, :expiry_date, :date
  end
end
