class CertifyArtisansController < ApplicationController
  def get_uncertified_artisans
    @uncertified_artisans = User.all.where(user_type: 'taskee', certified: false)
    render 'certify_artisans'
  end
end
