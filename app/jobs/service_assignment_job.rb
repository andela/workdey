class ServiceAssignmentJob < ActiveJob::Base
  queue_as :default

  def perform(service)
    if service.accepted?
      break
    elsif service.expired?
      notify_tasker("service request took too long to be assigned", service)
    else
      assignment = ServiceAssignment.assign(service)
      if assignment
        notify_artisan("you have a new service request", assignment)
        ServiceAssignmentJob.set(wait: 30.minutes).perform_later(service)
      else
        notify_tasker("there are no artisans to perform your task", service)
      end
    end
  end

  private

  def notify_artisan(message, assignment)
    Notification.create(
      message: message,
      sender_id: nil,
      receiver_id: assignment.user_id,
      notifiable_id: assignment.service_id,
      notifiable_type: "Services"
    )
  end

  def notify_tasker(message, service)
    Notification.create(
      message: message,
      sender_id: nil,
      receiver_id: service.tasker.id,
      notifiable_id: service.id,
      notifiable_type: "Services"
    )
  end
end
