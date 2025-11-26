class QuestionsController < ApplicationController
  def update
    @question = Question.find(params[:id])
    @quiz = @question.quiz
    if @question.update(question_params)
      redirect_to @quiz # or wherever
    else
      render :edit
    end
  end

  private

  def question_params
    params.require(:question).permit(:user_answer, :score)
  end
end
