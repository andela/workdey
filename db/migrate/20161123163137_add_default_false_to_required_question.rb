class AddDefaultFalseToRequiredQuestion < ActiveRecord::Migration
  def change
    change_column :questions, :required, :boolean, default: true
  end
end
