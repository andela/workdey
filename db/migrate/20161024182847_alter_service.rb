class AlterService < ActiveRecord::Migration
  def change
    change_column_default(:services, :status, 0)
  end
end
