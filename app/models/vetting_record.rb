class VettingRecord < ActiveRecord::Base
  belongs_to :user

  def find_by_user_id(user_id)
    self.find_by(user_id: user_id)
  end
end
