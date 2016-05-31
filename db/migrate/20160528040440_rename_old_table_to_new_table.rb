class RenameOldTableToNewTable < ActiveRecord::Migration
  def change
    rename_table :taskee_biddings, :bid_managements
  end
end
