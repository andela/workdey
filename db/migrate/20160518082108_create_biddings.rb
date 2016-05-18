class CreateBiddings < ActiveRecord::Migration
  def change
    create_table :biddings do |t|
      t.references :task, index: true, foreign_key: true
      t.text :description
      t.string :price_range

      t.timestamps null: false
    end
  end
end
