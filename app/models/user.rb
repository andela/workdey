class User < ActiveRecord::Base
  has_many :skillsets
  has_many :reviews
  has_many :reviewers, class_name: "Review", foreign_key: :reviewer_id
  has_many :tasks, through: :skillsets
  has_many :tasks_given, class_name: "TaskManagement", foreign_key: :taskee_id
  has_many :tasks_created, class_name: "TaskManagement", foreign_key: :tasker_id
  has_one :user_plan
  has_many :biddings, foreign_key: :tasker_id
  has_many :bid_managements, foreign_key: :taskee_id

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
            length: { minimum: 8 }

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

  def review_comments
    reviews.where("review != ?", "")
  end

  def self.get_user_address(user_email)
    where("email = ?", user_email).pluck(:city, :street_address)
  end

  def self.get_taskees_by_skillset(skillset, _user_email = nil)
    # query_string = keyword.to_s.capitalize
    # taskees = User.joins("JOIN skillsets ON skillsets.user_id = users.id").
    #           joins("JOIN tasks ON skillsets.task_id = tasks.id").
    #           where("tasks.name LIKE ?", query_string)
    # return nil if taskees.nil? || taskees.empty?
    # return taskees if user_email.nil?
    # taskees.where("email != ?", user_email)
    User.joins(:skillsets).where(
      "LOWER(name) LIKE ?", "%#{skillset.downcase}%"
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

  def taskee?
    user_type == "taskee"
  end

  def tasker?
    user_type == "tasker"
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
