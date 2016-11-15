class AddCanSelectMultipleToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :can_select_multiple, :boolean, default: false
  end
end
