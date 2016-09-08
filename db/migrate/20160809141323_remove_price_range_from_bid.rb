class RemovePriceRangeFromBid < ActiveRecord::Migration
  def change
    remove_column :bids, :price_range
  end
end
