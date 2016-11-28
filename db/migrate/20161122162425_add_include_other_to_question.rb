class AddIncludeOtherToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :include_other, :boolean, default: false
  end
end
