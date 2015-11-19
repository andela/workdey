class AddColumnConfirmationFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirm_token, :string
    add_column :users, :confirmed, :boolean, default: false
  end
end
