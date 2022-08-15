# frozen_string_literal: true

# This shiny device polishes bared Answers
class AnswersController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_question!
  before_action :set_answer!, except: :create

  def update
    if @answer.update answer_params
      flash[:success] = 'Ответ обновлен!!'
      redirect_to question_path(@question, anchor: dom_id(@answer))
    else
      render :edit
    end
  end

  def edit; end

  def create
    @answer = @question.answers.build answer_params

    if @answer.save
      flash[:success] = 'Ответ создан!'
      redirect_to question_path(@question)
    else
      @answers = @question.answers.order created_at: :desc
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = 'Ответ удален!'
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find params[:question_id]
  end

  def set_answer!
    @answer = @question.answers.find params[:id]
  end
end
