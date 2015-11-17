class Task < ActiveRecord::Base
  has_many :skillsets
  has_many :users, through: :skillsets

  def self.get_task_doers(keyword)
    query_string = "%#{keyword.capitalize}%"
    taskee = where("name LIKE ?", query_string)
    taskee.first.users if !taskee.first.nil?
  end

end