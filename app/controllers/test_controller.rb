class TestController < WebsocketRails::BaseController
  def foo
    # current_user.user_type == "tasker" ? notify_tasker : notify_taskee
    # data = TaskManagement.where(taskee_id: id).where(taskee_notified: false)
    # WebsocketRails.users[connection].send_message :new_task, message
  end

  # def client_connected
  #   require "pry"; binding.pry
  #   foo = TaskManagement.where(taskee_id: id).where(taskee_notified: false)
  #   WebsocketRails.users[current_user.id].send_message :new_task, foo
  # end
end
