class ServiceAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :service

  def self.assign(service)
    service.skillset.artisans.sort_by(&:overall_rating).reverse.each do |artisan|
      assignment = service.service_assignments.find_by(user_id: artisan.id)
      unless assignment
        service.update(artisan_id: artisan.id, status: :assigned)
        return ServiceAssignment.create(
          service_id: service.id,
          user_id: artisan.id
        )
      end
    end
    nil
  end
end
