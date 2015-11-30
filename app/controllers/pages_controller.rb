class PagesController < ApplicationController
  # before_action :guest_only, only: [:index]

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
    if current_user
      user_email = current_user.email
      all_taskees = Task.get_taksees(params[:searcher], user_email)
      @taskees = all_taskees.first.concat(all_taskees[1]) unless all_taskees.nil?
    else
      @taskees = Task.all_taskees(params[:searcher])
    end
    render "search_result"

  end

end
