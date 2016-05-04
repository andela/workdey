class TaskManagementsPresenter
  def initialize(task)
    @task = task
  end

  def tasker_details(view)
    tasker = User.find(@task.tasker_id)
    view.content_tag(:td, "#{tasker.firstname} #{tasker.lastname}")
  end

  def task_description(view)
    view.content_tag(:td, @task.task_desc.to_s)
  end

  def task_status(view)
    status = @task.status

    if status == "done"
      view.content_tag(
        :td,
        "<i class='tiny material-icons'>done</i> #{status.downcase}".html_safe,
        class: ["teal-text text-darken-2"])
    elsif status == "active"
      view.content_tag(
        :td,
        "<i class='tiny material-icons'>trending_flat</i> #{status.downcase}".
        html_safe, class: ["cyan-text"])
    elsif status == "inactive"
      view.content_tag(
        :td,
        "<i class='tiny material-icons'>not_interested</i> #{status.downcase}".
        html_safe, class: ["red-text"])
    elsif status == "rejected"
      view.content_tag(
        :td,
        "<i class='tiny material-icons'>thumb_down</i> #{status.downcase}".
        html_safe, class: ["grey-text text-lighten-1"])
    end
  end

  def method_missing(method)
    @task.send(method)
  rescue
    nil
  end
end
