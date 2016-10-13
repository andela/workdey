class VettingRecord < ActiveRecord::Base
  belongs_to :user
  scope :find_by_user_id, -> (user_id) { find_by(user_id: user_id) }
end
