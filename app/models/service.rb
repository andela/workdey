class Service < ActiveRecord::Base
  has_many :quotes
  enum status: [:assigned, :unassigned, :accepted]
end
