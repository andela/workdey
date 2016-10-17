class ArtisanSkillset < ActiveRecord::Base
  belongs_to :skillset
  belongs_to :artisan, class_name: "User"
end
