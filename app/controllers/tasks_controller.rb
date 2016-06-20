class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    binding.pry
  end

  # def skillsets
  #   @skillsets = Skillset.all.pluck(:name).compact
  # end
end
