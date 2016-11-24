class Admin::QuestionsController < ApplicationController
  before_action :login_required
  before_action :require_admin
  before_action(
    :find_question,
    only: [:edit, :update, :destroy, :promote, :demote]
  )

  def index
    @questions = Question.ranked
  end

  def show
    redirect_to admin_questions_path
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

  def update
    if @question.update(edit_question_params)
      redirect_to admin_questions_path
    else
      render "edit"
    end
  end

  def destroy
    @question.destroy
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

  def preview
    @questions = Question.ranked
  end

  private

  def find_question
    @question = Question.find_by(id: params[:id])
  end

  def edit_question_params
    edit_params = question_params
    edit_params[:options] = [] unless edit_params.key?(:options)
    edit_params
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
