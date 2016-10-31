class ServiceAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :service

  def self.assign(service)
    service.skillset.artisans.sort_by(&:avg_rating).reverse.each do |artisan|
      assigned_before = service.service_assignments.find_by(user_id: artisan.id)
      unless assigned_before
        service.assign(artisan)
        return ServiceAssignment.create(
          service_id: service.id,
          user_id: artisan.id
        )
      end
    end
    false
  end

  def update_accepted
    update(accepted: true)
  end
end
