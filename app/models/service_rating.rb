class ServiceRating < ActiveRecord::Base
  belongs_to :service

  enum category: { tasker_to_artisan: 1, artisan_to_tasker: 2 }

  validates :rating,
            presence: true,
            inclusion: { in: 1..5 }

  validates :private_feedback,
            presence: true,
            length: { minimum: 3,
                      message: "Too short. The minimum length"\
                                " is 3 characters." }

  validates :public_feedback,
            presence: true,
            length: { minimum: 3,
                      message: "Too short. The minimum length"\
                                " is 3 characters." }

  validates :category,
            presence: true

  def self.get_ratings(user)
    if user.artisan?
      get_artisan_rating(user)
    elsif user.tasker?
      get_tasker_rating(user)
    else
      ServiceRating.all
    end
  end

  def self.compute_average_rating(user)
    if user.artisan?
      get_artisan_average_rating(user)
    else
      get_tasker_average_rating(user)
    end
  end

  def self.get_artisan_rating(user)
    joins(:service).where(
      category: ServiceRating.categories[:tasker_to_artisan],
      services: { artisan_id: user.id }
    )
  end

  def self.get_tasker_rating(user)
    joins(:service).where(
      category: ServiceRating.categories[:artisan_to_tasker],
      services: { tasker_id: user.id }
    )
  end

  def self.get_artisan_average_rating(user)
    joins(:service).where(
      category: ServiceRating.categories[:tasker_to_artisan],
      services: { artisan_id: user.id }
    ).average(:rating)
  end

  def self.get_tasker_average_rating(user)
    joins(:service).where(
      category: ServiceRating.categories[:artisan_to_tasker],
      services: { tasker_id: user.id }
    ).average(:rating)
  end
end
