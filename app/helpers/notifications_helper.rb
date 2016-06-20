module NotificationsHelper
  def show_notifications(notification)
    css_class_name = notification.viewed ? "feed viewed" : "feed"
    tasker_image = notification.sender.image_url
    task = notification.id
    generate_html(css_class_name, tasker_image, notification.message, task)
  end


  def generate_html(css_class_name, tasker_image, message, task)
    raw "<div class='#{css_class_name}'>
      #{cl_image_tag tasker_image}
      <p class='title'>#{message}</p>
      #{button_tag 'view', class: 'btn', data: { id: task }}
    </div>"
  end
end
