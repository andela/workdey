class DropBidding < ActiveRecord::Migration
  def change
    drop_table :biddings, force: :cascade
  end
end
