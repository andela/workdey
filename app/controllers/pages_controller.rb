class PagesController < ApplicationController
  before_action :guest_only, only: :index
  before_action :show_notification_count, only: :search

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

  def become_a_taskee
  end

  def search
    if params[:searcher] || session[:searcher]
      session[:searcher] = params[:searcher] if params[:searcher]
      @taskees = get_taskees_by_search(session[:searcher])
    end
    render "search_result"
  end

  protected

  def get_taskees_by_search(keyword)
    return User.get_taskees_by_task_name(keyword) unless current_user
    user_email = current_user.email
    Task.get_taskees(keyword, user_email)
  end
end
