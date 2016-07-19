class AddColumnsToReference < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :references, :skillsets, :hstore, default: {}, null: false
  end
end
