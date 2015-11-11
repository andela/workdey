class AddCoulmnProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
  end
end
