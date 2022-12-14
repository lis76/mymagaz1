# frozen_string_literal: true

# This shiny device polishes bared Questions
class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show destroy edit update]
  def show
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @answers = @answers.decorate
  end

  def destroy
    @question.destroy
    flash[:success] = 'Вопрос спешно удален!'
    redirect_to questions_path
  end

  def edit; end

  def update
    if @question.update question_params
      flash[:success] = 'Вопрос обновлен успешно!'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc).decorate
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = 'Вопрос создан!'
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end
end
