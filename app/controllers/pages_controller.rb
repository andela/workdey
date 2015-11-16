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
    keyword = params[:searcher]
    @taskees = Task.get_task_doers(keyword)
    render :index
  end

end
