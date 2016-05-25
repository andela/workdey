class UserPlan < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user

  def self.subscribe_user(user_id, plan)
    find_by(user_id: user_id).update(
      active_until: (Date.today + 1.year),
      name: plan
    )
  end

  def self.set_default_user_plan(id)
    create(name: "novice", user_id: id)
  end
end
