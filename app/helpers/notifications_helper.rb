module NotificationsHelper
  def show_notifications(notification)
    css_class_name = notification.user_notified ? "feed viewed" : "feed"
    tasker_image = notification.sender.image_url
    generate_html(
      css_class_name,
      tasker_image,
      notification.message,
      notification.id
    )
  end

  def generate_html(css_class_name, tasker_image, message, id)
    raw "<div class='#{css_class_name}'>
      #{cl_image_tag tasker_image}
      <p class='title'>#{message}</p>
      #{button_tag 'view', class: 'btn', data: { id: id }}
    </div>"
  end
end
