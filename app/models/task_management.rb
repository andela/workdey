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
end
