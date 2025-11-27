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

  # def next
  #   respond_to do |format|
  #   format.turbo_stream # renders `app/views/messages/create.turbo_stream.erb`
  #   format.html { redirect_to quiz_path(@quiz) }
  #   end
  # end


  

  private

  def question_params
    params.require(:question).permit(:user_answer, :score)
  end
end
