class AddDefaultStatus < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :string, default: "unassigned"
  end
end
