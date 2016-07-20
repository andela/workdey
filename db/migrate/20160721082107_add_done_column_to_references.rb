class AddDoneColumnToReferences < ActiveRecord::Migration
  def change
    add_column :references, :done, :boolean, default: false
  end
end
