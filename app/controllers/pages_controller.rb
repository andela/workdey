class PagesController < ApplicationController
  before_action :guest_only, only: :index
  before_action :show_notification_count, only: :search
  before_action :enquiry

  def index
  end

  def about
  end

  def contact
    if params[:message] != "" && !params[:message].nil?
      info = JSON.generate(name: params[:name],
                           email: params[:email],
                           subject: params[:subject],
                           message: params[:message])
      PostmanWorker.new.perform(info, 2)
      flash[:notice] = "Thanks for contacting us! We appreciate it."
    end
  end

  def terms
  end

  def become_a_artisan
  end

  def search
    if params[:searcher] || session[:searcher]
      session[:searcher] = params[:searcher] if params[:searcher]
      @artisans = get_artisans_by_search(session[:searcher])
      skillset = Skillset.where("LOWER(name) LIKE ?",
                                "%#{session[:searcher].downcase}%").first
      session[:searcher] = skillset.name if skillset
    end
    render "search_result"
  end

  protected

  def get_artisans_by_search(keyword)
    return User.get_artisans_by_skillset(keyword) unless current_user
    user_email = current_user.email
    Task.get_artisans(keyword, user_email)
  end
end
