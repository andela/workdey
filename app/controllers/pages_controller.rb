class PagesController < ApplicationController
  before_action :guest_only, only: [:index]

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
end
