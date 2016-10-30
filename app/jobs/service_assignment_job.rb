class ServiceAssignmentJob < ActiveJob::Base
  queue_as :default

  def perform(service)
    if service.accepted?
    elsif service.expired?
      service.update(artisan_id: nil, status: :unassigned)
      notify_tasker("service request took too long to be assigned", service)
    else
      assignment = ServiceAssignment.assign(service)
      if assignment
        notify_artisan("you have a new service request", assignment)
        ServiceAssignmentJob.set(wait: 15.seconds).perform_later(service)
      else
        service.update(artisan_id: nil, status: :unassigned)
        notify_tasker("there are no artisans to perform your task", service)
      end
    end
  end

  private

  def notify_artisan(message, assignment)
    Notification.create(
      message: message,
      sender_id: assignment.service.tasker.id,
      receiver_id: assignment.user_id,
      notifiable_id: assignment.service_id,
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
