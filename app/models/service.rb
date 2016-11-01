class Service < ActiveRecord::Base
  belongs_to :tasker, class_name: "User"
  belongs_to :artisan, class_name: "User"
  belongs_to :skillset

  validates :title,
            presence: true

  validates :description,
            presence: true

  validates :skillset_id,
            presence: true

  validates :start_date,
            presence: true

  validates :end_date,
            presence: true

  validates :duration,
            presence: true

  validates :status,
            presence: true

  validate :end_date_must_be_greater_than_start_date

  enum status: [:unassigned, :assigned, :accepted]

  scope :pending_requests, (lambda do |current_user|
    where("tasker_id = ? AND status = ?", current_user.id, 0)
  end)

  private

  def end_date_must_be_greater_than_start_date
    if start_date && end_date
      check_start_and_end_dates
    else
      errors[:date] = "Service date cannot be nil"
    end
  end

  def check_start_and_end_dates
    same_day = start_date == end_date
    unless (end_date > start_date &&
            end_date > Date.today && start_date >= Date.today) || same_day
      errors[:date] = "'Start Date' or 'End Date' cannot be in the past"
    end
  end
end
