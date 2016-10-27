class ServiceAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  validates :accepted, presence: true

  def self.assign(service)
    service.skillset.artisans.order(rating: :desc).each do |artisan|
      assignment = service.service_assignments.find_by(user_id: artisan.id)
      unless assignment
        service.update(artisan_id: artisan.id, status: :assigned)
        return ServiceAssignment.create(service.id, artisan.id)
      end
    end
  end
end
