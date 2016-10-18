class User < ActiveRecord::Base
  has_many :artisan_skillsets, foreign_key: :artisan_id
  has_many :skillsets, through: :artisan_skillsets
  has_many :reviews
  has_many :reviewers, class_name: "Review", foreign_key: :reviewer_id
  has_many :tasks_assigned, class_name: "Task", foreign_key: :tasker_id
  has_many :tasks, class_name: "Task", foreign_key: :artisan_id
  has_many :tasks_given, class_name: "TaskManagement", foreign_key: :artisan_id
  has_many :tasks_created, class_name: "TaskManagement", foreign_key: :tasker_id
  has_one :user_plan
  has_many :biddings, foreign_key: :tasker_id
  has_many :bid_managements, foreign_key: :artisan_id
  has_many :notifications, class_name: "Notification", foreign_key: :receiver_id
  has_many :sent_notifications,
           class_name: "Notification",
           foreign_key: :sender_id
  has_many :references, foreign_key: :artisan_id
  has_many :artisan_skillsets, foreign_key: :artisan_id
  has_many :skillsets, foreign_key: :artisan_id, through: :artisan_skillsets
  has_one :vetting_record
  has_many :ratings, foreign_key: :user_id

  before_save { self.email = email.downcase }
  before_create :generate_confirm_token, unless: :oauth_user?

  ALLOWED = /\A[^\d]+\z/
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\.]+[\w+]\.[a-z]+\z/i

  has_secure_password

  validates :firstname,
            presence: true,
            length: { in: 2..50 },
            format: { with: ALLOWED }

  validates :lastname,
            presence: true,
            length: { in: 2..50 },
            format: { with: ALLOWED }

  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL }

  validates :password,
            presence: true,
            length: { minimum: 8 },
            on: :create

  scope :artisans, -> { where(user_type: "artisan") }

  enum status: [:not_reviewed, :accepted, :rejected, :certified]

  def self.first_or_create_from_oauth(auth)
    where(email: auth.info.email).first_or_create do |u|
      u.provider = auth.provider
      u.oauth_id = auth.uid
      u.firstname = auth.info.name.split(" ").first
      u.lastname = auth.info.name.split(" ").last
      u.email = auth.info.email
      u.password = SecureRandom.urlsafe_base64
      u.image_url = auth.info.image
      u.confirmed = true
    end
  end

  def self.confirm_user(token)
    user = find_by_confirm_token(token)
    user ? user.update_attribute(:confirmed, true) : false
  end

  def average_rating(user_id)
    average = Review.connection.execute("SELECT (SUM(rating) / COUNT(rating))
                              AS average
                              FROM reviews
                              WHERE user_id = #{user_id}").first["average"]
    average.nil? ? 0 : average
  end

  def has_no_reviews?
    reviews.map(&:review).all? { |comment| comment == "" }
  end

  def fullname
    "#{firstname} #{lastname}"
  end

  def review_comments
    reviews.where("review != ?", "")
  end

  def self.get_user_address(user_email)
    where("email = ?", user_email).pluck(:city, :street_address)
  end

  def self.get_artisans_by_skillset(skillset)
    User.joins(:skillsets).where(
      "name ILIKE ?", "%#{skillset}%"
    )
  end

  def novice?
    user_plan && user_plan.name == "novice"
  end

  def medial?
    user_plan && user_plan.name == "medial"
  end

  def maestro?
    user_plan && user_plan.name == "maestro"
  end

  def artisan?
    user_type == "artisan"
  end

  def tasker?
    user_type == "tasker"
  end

  def admin?
    user_type == "admin"
  end

  def skillset_ids
    artisan_skillsets.map(&:skillset_id)
  end

  private_class_method
  def self.users
    User.arel_table
  end

  def self.skillsets
    Skillset.arel_table
  end

  def self.tasks
    Task.arel_table
  end

  private

  def generate_confirm_token
    self.confirm_token = SecureRandom.uuid
  end

  def oauth_user?
    !oauth_id.nil?
  end
end
