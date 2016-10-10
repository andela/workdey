class Admin < User
  scope :get_applicants, lambda{
    where(user_type: "taskee", status: 0)
  }
end
