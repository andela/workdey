class ServiceAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :service

  def self.assign(service)
    service.skillset.artisans.sort_by(&:avg_rating).reverse.each do |artisan|
      assigned_before = service.service_assignments.find_by(user_id: artisan.id)
      next if assigned_before || artisan.busy?
      service.assign(artisan)
      return ServiceAssignment.create(
        service_id: service.id,
        user_id: artisan.id
      )
    end
    false
  end

  def update_accepted
    update(accepted: true)
  end
end
