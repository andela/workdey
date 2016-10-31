class SpecifyDefaultStatusInQuote < ActiveRecord::Migration
  def change
    change_column :quotes, :status, :integer, default: 0
  end
end
