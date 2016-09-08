class AddPriceToBid < ActiveRecord::Migration
  def change
    add_column :bids, :price, :decimal, precision: 8, scale: 0
  end
end
