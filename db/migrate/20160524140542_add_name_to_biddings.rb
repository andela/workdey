# frozen_string_literal: true
class AddNameToBiddings < ActiveRecord::Migration
  def change
    add_column :biddings, :name, :string
  end
end
