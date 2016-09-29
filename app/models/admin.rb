class Admin < User
  def self.get_applicants
    User.where(["user_type = ? and status = ?", "taskee", 0])
  end
end
