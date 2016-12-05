class RenameTypeToCategory < ActiveRecord::Migration
  def change
    rename_column :service_ratings, :type, :category
  end
end
