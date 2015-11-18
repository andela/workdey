class PagesController < ApplicationController
  before_filter :guest_only, only: [:index]

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
