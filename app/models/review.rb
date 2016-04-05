class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewer, class_name: "User"
end
