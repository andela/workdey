require "delegate"

class TaskManagementsPresenter < SimpleDelegator
  def tasker_details(view)
    tasker = User.find(model.tasker_id)
    view.content_tag(:td, "#{tasker.firstname} #{tasker.lastname}")
  end

  def task_description(view)
    view.content_tag(:td, model.task_desc.to_s)
  end

  def task_status(view)
    status = model.status

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

  def model
    __getobj__
  end
end
