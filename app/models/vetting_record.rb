class VettingRecord < ActiveRecord::Base
  belongs_to :user
  validates :skill_proficiency, :experience, :confidence, presence: true
  scope :find_by_user_id, -> (user_id) { find_by(user_id: user_id) }
end
