class Question < ActiveRecord::Base
  validates :question, presence: true
  validates :required, inclusion: [true, false]
end
