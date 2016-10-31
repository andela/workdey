class ServiceAssignmentJob < ActiveJob::Base
  queue_as :default

  def perform(service)
    if service.accepted?
      service.service_assignments.last.update_accepted
    elsif service.expired?
      service.unassign
      notify_tasker("service request took too long to be assigned", service)
    elsif ServiceAssignment.assign(service)
      notify_artisan("you have a new service request", service)
      ServiceAssignmentJob.set(wait: 10.seconds).perform_later(service)
    else
      service.unassign
      notify_tasker("there are no artisans to perform your task", service)
    end
  end

  private

  def notify_artisan(message, service)
    Notification.create(
      message: message,
      sender_id: service.tasker_id,
      receiver_id: service.artisan_id,
      notifiable_id: service.id,
      notifiable_type: "Service"
    )
  end

  def notify_tasker(message, service)
    Notification.create(
      message: message,
      sender_id: service.tasker.id,
      receiver_id: service.tasker.id,
      notifiable_id: service.id,
      notifiable_type: "Service"
    )
  end
end
