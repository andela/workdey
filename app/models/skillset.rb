class Skillset < ActiveRecord::Base
  attr_accessor :was_created

  belongs_to :task
  belongs_to :user
end
