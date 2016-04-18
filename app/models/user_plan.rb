class UserPlan < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id

  def self.subscribe_user(user_id, plan)
    find_by(user_id: user_id).update_attributes(active_until: (Date.today + 1.year),
                                     name: plan)
  end

  def self.set_default_user_plan
    create(name: "novice", user_id: current_user.id)
  end
end
