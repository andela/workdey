class Skillset < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  attr_accessor :was_created
end
