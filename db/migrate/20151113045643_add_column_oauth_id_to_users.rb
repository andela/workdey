class AddColumnOauthIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_id, :string
  end
end
