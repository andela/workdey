class TaskManagement < ActiveRecord::Base
  belongs_to :taskee, class_name: "User"
  belongs_to :tasker, class_name: "User"
  belongs_to :task

  validates :amount,
            numericality: { greater_than_or_equal_to: 2000 },
            presence: true
  validate :end_time_must_be_later_than_start_time
  validates :task_id,
            :tasker_id,
            :taskee_id,
            :task_desc,
            presence: true
  
  def task_name
  end

  def self.notifications_count(user_type, id)
    if user_type == "taskee"
      where(taskee_id: id).where(taskee_notified: false).count
    else
      where(tasker_id: id).where(tasker_notified: false).
        where.not(status: "inactive").count
    end
  end

  def self.all_notifications_for(user_type, id)
    if user_type == "taskee"
      where(taskee_id: id, status: "inactive").
        order(viewed: :asc, created_at: :desc).
        select(:id, :task_id, :tasker_id, :viewed)
    else
      where(tasker_id: id).where.not(status: "inactive")
    end
  end

  def self.update_all_notifications_as_seen(user)
    query = user.user_type == "tasker" ? "tasker_id" : "taskee_id"
    attribute = query.gsub("id", "notified")
    where(query => user.id).where(attribute => false).
      update_all(attribute => true)
  end

  def end_time_must_be_later_than_start_time
    if start_time && end_time
      unless end_time > start_time && end_time > Time.now
        errors[:endtime] = "End_time cannot be in the past"
      end
    else
      errors[:time] = "Task time cannot be nil"
    end
  end
end
 