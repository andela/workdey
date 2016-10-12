class AddReasonToUser < ActiveRecord::Migration
  def change
    add_column :users, :reason, :string
  end
end
