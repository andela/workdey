# frozen_string_literal: true
module NotificationsHelper
  def show_notifications(notification)
    service_id = notification.notifiable.service.id if notification.notifiable_type == "Quote"
    css_class_name = notification.user_notified ? "feed viewed" : "feed"
    generate_html(
      css_class_name,
      notification.sender.image_url,
      notification.message,
      notification.id,
      notification.notifiable_type,
      service_id
    )
  end

  def generate_html(css_class_name, tasker_image, message, id, type, service_id)
    raw "<div class='#{css_class_name}', id='notification-item-#{id}'>
      #{cl_image_tag tasker_image}
      <p class='title'>#{message}</p>
      #{button_tag 'view', class: 'btn', data: { id: id, notification_type: type, notifiable_id: service_id}}
    </div>"
  end
end
