class MapController < WebsocketRails::BaseController

  def get_nearby_taskees
    taskees = get_all_taskees
    send_message :success, taskees.to_json, namespace: :taskees
  end

  def search_by_task
    taskees = get_all_taskees.select do |taskee|
      taskee if taskee[:tasks].include? message
    end
    send_message :success, taskees.to_json, namespace: :search_taskee
  end

  private

  def get_all_taskees
    nearby_taskees = []
    User.all.where(user_type: "taskee").each do |taskee|
      nearby_taskees << {
        name: "#{taskee[:firstname]} #{taskee[:lastname]}",
        email: taskee[:email],
        gender: taskee[:gender],
        phone: taskee[:phone],
        joined: taskee[:created_at],
        type: taskee[:user_type],
        link: user_profile_path(obfuscate(taskee_id: taskee[:id])),
        location: "#{taskee[:street_address]}. #{taskee[:state]}, "\
        "#{taskee[:city]}",
        coords: [taskee[:latitude], taskee[:longitude]],
        avatar: taskee[:image_url],
        distance: Haversine.distance(
          [current_user.latitude, current_user.longitude],
          [taskee[:latitude], taskee[:longitude]]
        ).to_kilometers,
        tasks: taskee.tasks.collect(&:name)
      }
    end
    nearby_taskees
  end
end
