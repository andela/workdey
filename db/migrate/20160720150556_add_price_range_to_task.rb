class AddPriceRangeToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :price_range, :text
  end
end
