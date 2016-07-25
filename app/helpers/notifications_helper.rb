# frozen_string_literal: true
module NotificationsHelper
  def show_notifications(object)
    css_class_name = object.viewed ? "feed viewed" : "feed"
    tasker_image = fetch_user(object).image_url
    tasker_name = fetch_user(object).firstname
    task_name = fetch_task(object).name
    task = object.id

    generate_html(css_class_name, tasker_image, tasker_name, task_name, task)
  end

  def fetch_user(object)
    @tasker ||= User.find(object.tasker_id)
  end

  def fetch_task(object)
    @task ||= Skillset.find(object.task_id)
  end

  def generate_html(css_class_name, tasker_image, tasker_name, task_name, task)
    raw "<div class='#{css_class_name}'>
      #{cl_image_tag tasker_image}
      <p class='title'> <strong>#{task_name} task</strong>
      from #{tasker_name} </p>
      #{button_tag 'view', class: 'btn', data: { id: task }}
    </div>"
  end
end
