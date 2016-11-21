class Admin::QuestionsController < ApplicationController
  before_action :find_question

  def index
    @questions = Question.ranked
  end

  def promote
    @question.promote_rank
    redirect_to admin_questions_path
  end

  def demote
    @question.demote_rank
    redirect_to admin_questions_path
  end

  def destroy
    redirect_to admin_questions_path
  end

  private

  def find_question
    @question = Question.find_by(id: params[:id])
  end
end
