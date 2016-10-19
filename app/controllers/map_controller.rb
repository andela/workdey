class MapController < WebsocketRails::BaseController
  def get_nearby_artisans
    artisans = get_all_artisans
    send_message :success, artisans.to_json, namespace: :artisans
  end

  def search_by_task
    artisans = get_all_artisans.select do |artisan|
      artisan if artisan[:tasks].include? message
    end
    send_message :success, artisans.to_json, namespace: :search_artisan
  end

  private

  def get_all_artisans
    nearby_artisans = []
    User.all.where(user_type: "artisan").each do |artisan|
      nearby_artisans << {
        name: "#{artisan[:firstname]} #{artisan[:lastname]}",
        email: artisan[:email],
        gender: artisan[:gender],
        phone: artisan[:phone],
        joined: artisan[:created_at],
        type: artisan[:user_type],
        link: user_profile_path(obfuscate(artisan_id: artisan[:id])),
        location: "#{artisan[:street_address]}. #{artisan[:state]}, "\
        "#{artisan[:city]}",
        coords: [artisan[:latitude], artisan[:longitude]],
        avatar: artisan[:image_url],
        distance: Haversine.distance(
          [current_user.latitude, current_user.longitude],
          [artisan[:latitude], artisan[:longitude]]
        ).to_kilometers,
        tasks: artisan.tasks.map(&:name)
      }
    end
    nearby_artisans
  end
end
