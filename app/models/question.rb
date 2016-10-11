class Question < ActiveRecord::Base
  validates :question, presence: true
  validates :required, inclusion: { in: [true, false] }
end
