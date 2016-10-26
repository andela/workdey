class ServiceAssignmentJob < ActiveJob::Base
  queue_as :default

  def perform(service)
    if service.accepted?
      # break task
    elsif service.expired?
      #stop execution
      #send inform mail to tasker
    elsif gone_through_all_artisans?
      #stop execution
      #send inform mail to tasker
    else
      # get highest rated available
      # assign
      # send notification to newly assigned artisan
      # send notification to old artisan, if any
      # call yourself here recursively in 30 minutes to check if artisan accepted
    end
  end

  ServiceAssignment [service_id, artisan_id]
end
