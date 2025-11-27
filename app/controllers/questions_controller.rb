class QuestionsController < ApplicationController
  def update
    @question = Question.find(params[:id])
    @quiz = @question.quiz
    if @question.update(question_params)
      # redirect_to @quiz # or wherever
    else
      render :edit
    end
    chat = RubyLLM.chat
    @response = chat.ask("You are a teacher giving a quiz to a student. Here is the question: #{@question.question_content} Here is the correct answer: #{@question.answer_content} Here is the student’s answer: #{@question.user_answer} In your response please give a grade between 0 and 100 based on the accuracy of their response. Only give an integer.")
    @score = @response.content.to_i
    @question.question_score = @score
    if @question.update(question_params)
      # redirect_to @quiz # or wherever
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

    # def validation
    #   chat = RubyLLM.chat
    #   @response = chat.ask("")
    #   @quiz_content = JSON.parse(@response.content)
    # end

  

  private

  def question_params
    params.require(:question).permit(:user_answer, :score)
  end
end
