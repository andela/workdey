class Skillset < ActiveRecord::Base
  attr_accessor :was_created

  has_many :tasks
  has_many :services
  has_many :artisan_skillsets, foreign_key: :skillset_id
  has_many :artisans,
           class_name: "User",
           through: :artisan_skillsets

  validates_presence_of :name
end
