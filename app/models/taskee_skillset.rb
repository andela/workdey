class TaskeeSkillset < ActiveRecord::Base
  belongs_to :skillset
  belongs_to :taskee, class_name: "User"
end
