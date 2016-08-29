class DropBidManagement < ActiveRecord::Migration
  def change
    drop_table :bid_managements, force: :cascade
  end
end
