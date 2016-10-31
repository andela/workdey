class Admin < User
  scope :get_applicants, lambda do
    where(user_type: "artisan", status: 0)
  end
end
