class AddNameToSkillset < ActiveRecord::Migration
  def change
    add_column :skillsets, :name, :string
  end
end
