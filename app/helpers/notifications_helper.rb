# frozen_string_literal: true
module NotificationsHelper
  def show_notifications(notification)
    css_class_name = notification.user_notified ? "feed viewed" : "feed"
    generate_html(
      css_class_name,
      notification.sender.image_url,
      notification.message,
      notification.id
    )
  end

  def generate_html(css_class_name, tasker_image, message, id)
    raw "<div class='#{css_class_name}', id='notification-item-#{id}'>
      #{cl_image_tag tasker_image}
      <p class='title'>#{message}</p>
      #{button_tag 'view', class: 'btn', data: { id: id }}
    </div>"
  end
end
