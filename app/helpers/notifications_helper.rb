# frozen_string_literal: true
module NotificationsHelper
  def show_notifications(notification)
    service_id = if notification.notifiable_type == "Quote"
                   notification.notifiable.service.id
                 end
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
    data_attributes = {
      id: id, notification_type: type,
      notifiable_id: service_id
    }
    raw "<div class='#{css_class_name}', id='notification-item-#{id}'>
      #{cl_image_tag tasker_image}
      <p class='title'>#{message}</p>
      #{button_tag 'view', class: 'btn', data: data_attributes}
    </div>"
  end
end
