class Skillset < ActiveRecord::Base
  attr_accessor :was_created

  belongs_to :user

  def self.get_taskees(skillsets)
    taskees = where(name: skillsets.split(",")).includes(:user).map(&:user)
     User.where(id: taskees.map(&:id))
  end
end
