# frozen_string_literal: true
class Skillset < ActiveRecord::Base
  attr_accessor :was_created

  has_many :tasks
  belongs_to :user
end
