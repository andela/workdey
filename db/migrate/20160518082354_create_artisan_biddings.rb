# frozen_string_literal: true
class CreateArtisanBiddings < ActiveRecord::Migration
  def change
    create_table :artisan_biddings do |t|
      t.references :bidding, index: true, foreign_key: true
      t.integer :artisan_id

      t.timestamps null: false
    end
  end
end
