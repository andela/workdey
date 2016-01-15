module ApplicationHelper
  def query_id
    query_id = current_user.user_type == "tasker" ? "tasker_id" : "taskee_id"
  end

  def tasks
    tasks = TaskManagement.where(query_id => current_user.id)
  end

  def show_notification_count
    if current_user.user_type == "taskee"
      all_tasks = tasks.where(notified: false)
      count = all_tasks.count

      return raw "<li class='notification-badge'>
                    <span>
                      #{count}
                    </span>
                  </li>"
    end

    if current_user.user_type == "tasker"
      all_tasks = tasks.where.not(status: "inactive")
      count = all_tasks.count

      return raw "<li class='notification-badge'>
                  <span>
                    #{count}
                  </span>
                </li>" unless count < 1
    end
  end

  # def notification_dropdown_content
  #   # <ul id="tasks" class="dropdown-content">
  #   #   <li>
  #   #    <a href="#">Hello bae</a>
  #   #   </li>
  #   # </ul>

  #   all_tasks = tasks.where(viewed: false)
  #   require "pry"; binding.pry
  # end
end
