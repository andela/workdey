# frozen_string_literal: true
class AddCoulmnProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
  end
end
