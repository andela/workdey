class Task < ActiveRecord::Base
  has_many :skillsets
  has_many :users, through: :skillsets

  def self.get_taskees(keyword, user_email)
    taskees = User.get_taskees_by_task_name(keyword, user_email)
    current_user_city_street user_email
    return taskees if taskees.nil?
    taskees_nearby = get_taskees_nearby(taskees, @user_street, @user_city)
    other_taskees = taskees - taskees_nearby
    [taskees_nearby, other_taskees]
  end

  def self.get_taskees_nearby(taskees, user_street, user_city)
    taskees_nearby = taskees.where("city LIKE ? AND street_address LIKE ?",
                                   user_city, user_street
                                  )
    if taskees_nearby.nil?
      taskees_nearby = taskees.where("city LIKE ?", user_city)
    end
    taskees_nearby
  end

  def self.current_user_city_street(user_email)
    user_addy = User.get_user_address user_email
    @user_city = "%#{user_addy.first.first}%"
    @user_street = "%#{user_addy[0][1]}%"
  end
end
