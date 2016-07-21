class Task < ActiveRecord::Base
  belongs_to :tasker, class_name: "User"

  belongs_to :skillset
  # has_many :users, through: :skillsets
  has_many :task_management, foreign_key: :task_id
  validates :name, presence: true
  validates :price,
            numericality: { greater_than_or_equal_to: 2000 },
            presence: true
  validates :tasker_id,
            :description,
            presence: true
  validate :end_time_must_be_greater_than_start_time

  def self.get_taskees(keyword, user_email)
    taskees = User.get_taskees_by_skillset(keyword, user_email)
    current_user_city_street user_email
    return nil if taskees.nil? || taskees.empty?
    taskees_nearby = get_taskees_nearby(taskees, @user_street, @user_city)
    other_taskees = taskees - taskees_nearby
    [taskees_nearby, other_taskees].flatten
  end

  def self.get_taskees_nearby(taskees, user_street, user_city)
    taskees_nearby = taskees.where(
      "LOWER(city) LIKE ? AND LOWER(street_address) LIKE ?",
      user_city,
      user_street
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

  def self.search_for_available_need(need)
    skill_with_tasks = Skillset.where(
      "LOWER(name) LIKE ?",
      "%#{need.downcase}%"
    ).includes(:tasks).first
    return skill_with_tasks unless skill_with_tasks
    skill_with_tasks.tasks.where(
      "taskee_id IS NULL AND start_date > ?",
      Time.now
    )
  end

  private_class_method
  def end_time_must_be_greater_than_start_time
    if start_date && end_date
      check_start_and_end_dates
    else
      errors[:time] = "Task time cannot be nil"
    end
  end

  def check_start_and_end_dates
    same_day = start_date == end_date
    unless (end_date > start_date && end_date > Time.now) || same_day
      errors[:date] = "End date cannot be in the past"
    end
  end

  def self.users
    User.arel_table
  end
end
