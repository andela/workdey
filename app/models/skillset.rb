class Skillset < ActiveRecord::Base
  attr_accessor :was_created
  belongs_to :user
  has_and_belongs_to_many :tasks

  def self.get_taskees_and_skillsets(skillsets)
    skillsets = where(name: skillsets.split(",")).includes(:user)
    taskees = skillsets.map(&:user)
    [User.where(id: taskees.map(&:id)), skillsets]
  end

  # def self.get_taskess_by_skillset(keyword)
  #   where(name: "")
  # end

  # def self.selected_skillsets
  #   @skillsets
  # end
end
