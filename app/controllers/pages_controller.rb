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
                           message: params[:message]
                          )
      PostmanWorker.new.perform(info, 2)
      flash[:notice] = "Thanks for contacting us! We appreciate it."
    end
  end

  def terms
  end

  def become_a_taskee
  end

  def search
    @taskees = get_taskees_by_search
    @taskees = nil if @taskees == []
    session[:searcher] = params[:searcher] unless @taskees.nil?
    render "search_result"
  end

  protected

  def get_taskees_by_search
    return User.get_taskees_by_task_name(params[:searcher]) unless current_user
    user_email = current_user.email
    all_taskees = Task.get_taskees(params[:searcher], user_email)
    return all_taskees.first.concat(all_taskees[1]) unless all_taskees.nil?
    []
  end
end
