module TasksHelper
  def task_action(task)
    if task.id
      "Edit this Task"
    else
      "Create New Task"
    end
  end

  def create_or_update(task)
    if task.id
      "Update Task"
    else
      "Create Task"
    end
  end

  def description_string(task)
    task.description[0, 48] + "..."
  end
end
