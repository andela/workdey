class VettingRecord < ActiveRecord::Base
  belongs_to :user
  validates :skill_proficiency, :experience, :confidence, presence: true

  def self.find_by_user_id(user_id)
    VettingRecord.find_by(user_id: user_id)
  end
end
