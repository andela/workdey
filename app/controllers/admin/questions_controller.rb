class Admin::QuestionsController < ApplicationController
  before_action :login_required
  before_action :require_admin
  before_action :ranked_questions, only: [:index, :preview]
  before_action(
    :find_question,
    only: [:edit, :update, :destroy, :promote, :demote]
  )

  def index
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to(admin_questions_path, notice: "Question successfully saved.")
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @question.update(edit_question_params)
      redirect_to(admin_questions_path, notice: "Question successfully edited.")
    else
      render "edit"
    end
  end

  def destroy
    @question.destroy
    redirect_to(admin_questions_path, notice: "Question successfully deleted.")
  end

  def promote
    @question.promote_rank
    redirect_to(admin_questions_path, notice: "Question successfully promoted.")
  end

  def demote
    @question.demote_rank
    redirect_to(admin_questions_path, notice: "Question successfully demoted.")
  end

  def preview
  end

  private

  def ranked_questions
    @questions = Question.ranked
  end

  def find_question
    @question = Question.find_by(id: params[:id])
    redirect_to(
      admin_questions_path,
      notice: "Question not found."
    ) unless @question
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
