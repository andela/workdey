class Task < ActiveRecord::Base
  has_many :skillsets
  has_many :users, through: :skillsets

  def self.get_task_doers(keyword)
    # Must ensure that task enteries in the db are in title case
    query_string = "%#{keyword.capitalize}%",
    where("name LIKE ?", query_string).first.users
  end

end