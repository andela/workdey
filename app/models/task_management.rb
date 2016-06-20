class TaskManagement < ActiveRecord::Base
  belongs_to :taskee, class_name: "User"
  belongs_to :tasker, class_name: "User"
  belongs_to :task

  has_many :notifications, as: :notifiable

  validates :amount,
            numericality: { greater_than_or_equal_to: 2000 },
            presence: true
  validate :end_time_must_be_later_than_start_time
  validates :task_id,
            :tasker_id,
            :taskee_id,
            :task_desc,
            presence: true

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
