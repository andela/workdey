class AddVettedByToVettingRecords < ActiveRecord::Migration
  def change
    add_column :vetting_records, :vetted_by, :integer
  end
end
