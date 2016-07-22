# frozen_string_literal: true
class AddNameToSkillset < ActiveRecord::Migration
  def change
    add_column :skillsets, :name, :string
  end
end
