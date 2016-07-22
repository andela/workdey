# frozen_string_literal: true
class AddColumnCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :street_address, :string
  end
end
