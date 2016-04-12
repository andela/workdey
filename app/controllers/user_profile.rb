class UserProfile < ApplicationController
  before_action :login_required

  def save_profile_pix(image)
    unless image.blank?
      cloud_hash = Cloudinary::Uploader.upload(image)
      return cloud_hash["url"].split("/").last
    end
  end

  def user_info(data, current_user)
    birthday = get_user_birthday(data[:date])
    city = current_user.city if data[:city] == "City"
    state = current_user.state if data[:state] == "State"
    gender = current_user.gender if data[:gender] == "Gender"
    birthday = current_user.birthday if birthday.nil?
    {
      phone: data[:phone],
      street_address: data[:street_address],
      city: city ? city : data[:city],
      state: state ? state : data[:state],
      gender: gender ? gender : data[:gender],
      birthday: birthday,
      updated_at: DateTime.now
    }
  end

  def get_user_birthday(data)
    if data
      day = data[:day]
      month = data[:month]
      year = data[:year]
      if day && month && year
        birthday = day + "-" + month + "-" + year
        return birthday.to_date if birthday =~ /[\d-]{8,10}/
      end
    end
  end

  def user_info_hash(profile_params, current_user)
    info_hash = user_info(profile_params, current_user)
    pix_name = save_profile_pix(profile_params[:user_pix])
    info_hash[:image_url] = pix_name unless pix_name.nil?
    info_hash
  end

  def get_user_location(current_user, location_params)
  end
end
