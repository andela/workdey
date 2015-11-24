class Task < ActiveRecord::Base
  has_many :skillsets
  has_many :users, through: :skillsets
end
