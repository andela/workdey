class RemoveCertifiedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :certified, :boolean
  end
end
