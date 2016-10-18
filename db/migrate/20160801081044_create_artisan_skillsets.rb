class CreateArtisanSkillsets < ActiveRecord::Migration
  def change
    create_table :artisan_skillsets do |t|
      t.references :skillset, index: true, foreign_key: true
      t.integer :artisan_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
