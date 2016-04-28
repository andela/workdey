class AddExpiryDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :expiry_date, :date
  end
end
