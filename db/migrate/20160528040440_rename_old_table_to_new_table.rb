# frozen_string_literal: true
class RenameOldTableToNewTable < ActiveRecord::Migration
  def change
    rename_table :artisan_biddings, :bid_managements
  end
end
