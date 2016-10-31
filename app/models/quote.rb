class Quote < ActiveRecord::Base
  enum status: [:pending, :accepted, :rejected]
end
