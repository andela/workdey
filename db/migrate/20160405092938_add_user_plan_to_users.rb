class AddUserPlanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_plan, :string
  end
end
