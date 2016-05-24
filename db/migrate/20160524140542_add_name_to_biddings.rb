class AddNameToBiddings < ActiveRecord::Migration
  def change
    add_column :biddings, :name, :string
  end
end
