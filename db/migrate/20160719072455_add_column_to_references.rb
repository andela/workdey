class AddColumnToReferences < ActiveRecord::Migration
  def change
    add_column :references, :confirmation_token, :string, null: false, index: true
  end
end
