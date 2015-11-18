class PagesController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def terms
  end

  def become_a_taskee
  end

  def search
    user_email = "olaide.ojewale@andela.com"
    all_taskees = Task.get_taksees(params[:searcher], user_email)
    @taskees = all_taskees.first.concat(all_taskees[1]) unless all_taskees.nil?
    render "search_result"
  end

end
