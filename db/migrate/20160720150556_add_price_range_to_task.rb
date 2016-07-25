# frozen_string_literal: true
class AddPriceRangeToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :price_range, :text
  end
end
