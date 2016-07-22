# frozen_string_literal: true
class RemoveColumnCountryFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :country, :string
  end
end
