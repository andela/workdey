# frozen_string_literal: true
class Skillset < ActiveRecord::Base
  attr_accessor :was_created

  has_many :tasks
  has_many :taskees,
           class_name: "User",
           foreign_key: :taskee_id,
           through: :taskee_skillsets
  belongs_to :user
end
