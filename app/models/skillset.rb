class Skillset < ActiveRecord::Base
  attr_accessor :was_created

  belongs_to :task
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :task_id
end
