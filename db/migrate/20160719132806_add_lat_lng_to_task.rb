# frozen_string_literal: true
class AddLatLngToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :latitude, :decimal, precision: 10, scale: 6
    add_column :tasks, :longitude, :decimal, precision: 10, scale: 6
  end
end
