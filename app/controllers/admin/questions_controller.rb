class Admin::QuestionsController < ApplicationController
  before_action :find_question

  def index
    @questions = Question.ranked
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_questions_path
    else
      render "new"
    end
  end

  def edit
  end

  def destroy
    redirect_to admin_questions_path
  end

  def promote
    @question.promote_rank
    redirect_to admin_questions_path
  end

  def demote
    @question.demote_rank
    redirect_to admin_questions_path
  end

  private

  def find_question
    @question = Question.find_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(
      :required,
      :can_select_multiple,
      :include_other,
      options: []
    ).merge(question: params[:Question])
  end
end
