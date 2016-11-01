class Admin < User
  scope :get_applicants, lambda {
    where(user_type: "artisan", status: 0)
  }
end
