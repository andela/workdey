class Task < ActiveRecord::Base
  has_many :users, through: :skillsets
  has_many :task_management, foreign_key: :task_id
  has_and_belongs_to_many :skillsets
  validates :name, presence: true
  validate :end_time_must_be_later_than_start_time
  validates :price,
            numericality: { greater_than_or_equal_to: 2000 },
            presence: true
  validates :tasker_id,
            :description,
            presence: true

  def self.get_taskees(skillset, user_email)
    # taskees = User.get_taskees_by_task_name(keyword, user_email)
    taskees = User.get_taskees_by_skillset(skillset)
    current_user_city_street user_email
    return nil if taskees.nil? || taskees.empty?
    taskees_nearby = get_taskees_nearby(taskees, @user_street, @user_city)
    other_taskees = taskees - taskees_nearby
    [taskees_nearby, other_taskees].flatten
  end

  def self.get_taskees_nearby(taskees, user_street, user_city)
    taskees_nearby = taskees.where(
      "LOWER(city) LIKE ? AND LOWER(street_address)"\
      " LIKE ?", user_city, user_street
    )
    if taskees_nearby.nil?
      taskees_nearby = taskees.where("LOWER(city) LIKE ?", user_city)
    end
    taskees_nearby
  end

  def self.current_user_city_street(user_email)
    user_addy = User.get_user_address user_email
    @user_city = "%#{user_addy.first.first}%"
    @user_street = "%#{user_addy[0][1]}%"
  end

  def self.assign_task(taskee_id, task_id, skillsets)
    task = Task.find(task_id)
    if skillsets
      task.skillsets << Skillset.where("LOWER(name) LIKE ?", "%#{skillsets}%")
    else
      task.update_attributes(taskee_id: taskee_id, status: "assigned")
    end
  end

  def add_skillsets_to_task(task_skillset)
    skillsets << task_skillset
  end

  def end_time_must_be_later_than_start_time
    if start_date && end_date
      unless end_date > start_date && end_date > Time.now
        errors[:end_date] = "End_time cannot be in the past"
      end
    else
      errors[:date] = "Task date cannot be nil"
    end
  end

  private_class_method
  def self.users
    User.arel_table
  end
end
