class Admin::QuestionsController < ApplicationController
  def index
    @questions = Question.ranked
  end
end
