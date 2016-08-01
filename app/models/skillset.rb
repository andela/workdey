class Skillset < ActiveRecord::Base
  attr_accessor :was_created

  has_many :tasks
  has_many :taskee_skillsets, foreign_key: :skillset_id
  has_many :taskees,
           class_name: "User",
           through: :taskee_skillsets

  validates_presence_of :name
end