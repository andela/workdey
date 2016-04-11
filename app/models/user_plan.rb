class UserPlan < ActiveRecord::Base
  belongs_to :user

  def self.check_plan_and_status(user_id)
    where(id: user_id).pluck(:plan, :active_until)
  end

end
