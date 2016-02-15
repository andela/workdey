class RemoveColumnFromSkillsets < ActiveRecord::Migration
  def change
    remove_column :skillsets, :rate, :string
  end
end
