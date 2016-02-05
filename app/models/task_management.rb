class TaskManagement < ActiveRecord::Base
  belongs_to :taskees, class_name: "User"
  belongs_to :taskers, class_name: "User"
  has_one :task, foreign_key: :id

  validates :amount,
            numericality: { greater_than_or_equal_to: 2000 },
            presence: true

  validates :task_id,
            :tasker_id,
            :taskee_id,
            :start_time,
            :end_time,
            :task_desc,
            presence: true

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
    attribute =
      user.user_type == "tasker" ? "tasker_notified" : "taskee_notified"
    where(query => user.id).where(attribute => false).
      update_all(attribute => true)
  end

  def self.statistics_count(user_type, id)
    completed_tasks = where("#{user_type}_id = ?", id).where(status: "done").count
    scheduled_tasks = where("#{user_type}_id = ?", id).where(status: "active").count
    [completed_tasks, scheduled_tasks] if completed_tasks != 0 && scheduled_tasks != 0
  end
end
