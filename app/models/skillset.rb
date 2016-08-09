# frozen_string_literal: true
class Skillset < ActiveRecord::Base
  has_many :tasks
  has_many :taskee_skillsets, foreign_key: :taskee_id
  has_many :taskees,
           class_name: "User",
           foreign_key: :taskee_id,
           through: :taskee_skillsets

  validates_presence_of :name
end
