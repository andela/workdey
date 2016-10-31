class Service < ActiveRecord::Base
  enum status: [:assigned, :unassigned, :accepted]
end
