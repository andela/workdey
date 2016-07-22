# frozen_string_literal: true
class AddLongitudeAndLatitude < ActiveRecord::Migration
  def change
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
  end
end
