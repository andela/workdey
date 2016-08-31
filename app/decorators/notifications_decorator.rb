# frozen_string_literal: true
class NotificationsDecorator < Draper::Decorator
  delegate_all

  def broadcast_taskee_notifications
    h.raw "
    <div class='#{broadcast_class_name} row' id='notifications-item'>
      <div class='tasker-image col s2'>#{h.cl_image_tag sender.image_url}</div>
      <div class='task_desc col s7'>
      <span class='title'>#{title}</span>
        <span class='location'>
          <i class='tiny material-icons'>location_on</i> #{notifiable.location}
        </span>
        <span class='bids'>#{notifiable.bids.count} bids</span>
        <span class='timeline'>
          Due in #{h.distance_of_time_in_words_to_now(notifiable.end_date)}
        </span>
      </div>
      <div class='price action col s3'>
        <span>
        #{h.number_to_currency(notifiable.price_range.first, precision: 0)}
        #{broadcast_price}
        </span>
        #{h.link_to 'View Task',
                    h.dashboard_task_path(notifiable),
                    class: 'waves-effect waves-light btn notify-btn',
                    data: { id: id }}
      </div>
    </div>
    "
  end

  def broadcast_tasker_notifications
    h.raw "
    <div class='#{broadcast_class_name} row' id='notifications-item'>
      <div class='tasker-image col s2'>#{h.cl_image_tag sender.image_url}</div>
      <div class='task_desc col s7'>
        <span class='title'>#{message}</span>
        <span class='location'>
          <i class='tiny material-icons'>location_on</i>#{task.location}
        </span>
        <span class='bids'>#{task.bids.count} bids</span>
        <span class='timeline'>
          Due in #{h.distance_of_time_in_words_to_now(task.end_date)}
        </span>
      </div>
      <div class='price action col s3'>
        <span>
        #{h.number_to_currency(notifiable.price, precision: 0)}
        </span>
        #{h.link_to 'View Task',
                    h.dashboard_task_path(notifiable.task),
                    class: 'waves-effect waves-light btn notify-btn',
                    data: { id: id }}
      </div>
    </div>
    "
  end

  def share_contact_notifications
    h.raw "
    <div class='viewed feed'>
      <img src='#{sender.image_url}' alt='' />
      <p class='title'>#{message}</p>
      <a href='#modal1' onclick='modal_object(#{sender.to_json}, #{id})' class='btn info_btn modal-trigger'> view information</a>
    </div>
    "
  end

  private

  def task
    notifiable.task
  end

  def broadcast_class_name
    user_notified ? "feed viewed" : "feed"
  end

  def broadcast_price
    if notifiable.price_range.last.to_i.positive?
      "- #{h.number_to_currency(notifiable.price_range.last, precision: 0)}"
    end
  end

  def title
    if message.downcase.include?("assign")
      message
    else
      notifiable.name.to_s
    end
  end
end
