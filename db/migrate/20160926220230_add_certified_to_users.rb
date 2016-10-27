class AddCertifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :certified, :boolean
  end
end
