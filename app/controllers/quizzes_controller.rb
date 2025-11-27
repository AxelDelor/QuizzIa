
class QuizzesController < ApplicationController

  def new
    @quiz = Quiz.new
  end

  def show
    @quiz = Quiz.find(params[:id])
    @question = @quiz.questions.first
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
    @number_of_questions = @quiz.number_of_questions
    @level = @quiz.level
    @theme = @quiz.theme
    chat = RubyLLM.chat
    @response = chat.ask("create a questionnaire with #{@number_of_questions} questions and their answers on the subject of #{@theme},  the questionnaire should have a difficulty level of #{@level} please give your response in the format of a array of hash that I can parse with JSON.parse : [ { 'question': 'What is the capital of France?', 'reponse': 'Paris' }, { 'question': 'what is the sum of 2 and 2', 'reponse': '4'}, { 'question': 'Who wrote 'Ulysses'?', 'reponse': 'James Joyce' } ]. do not add any linebreak in your response")
    @quiz.save
    @quiz_content = JSON.parse(@response.content)

    @quiz_content.each do |item|
      question = item["question"]
      reponse = item["reponse"]
      Question.create(question_content: question, answer_content: reponse, quiz_id: @quiz.id)
    end
    redirect_to quiz_path(@quiz)
  end

  def next
    @question = Question.find(params[:id])
    @quiz = @question.quiz

    @next_question = @quiz.questions.where("id > ?", @question.id).first

    if @next_question.nil?
      # No more questions → redirect to quiz summary or end page
      redirect_to quiz_path(@quiz)
      return
    else
      respond_to do |format|
      #   format.turbo_stream   # renders questions/next.turbo_stream.erb
      #   format.html { redirect_to quiz_path(@quiz) }
      # end
        format.turbo_stream { render turbo_stream: turbo_stream.replace("question", partial: "questions/card", locals: { question: @next_question }) }
        format.html { render "quizzes/show" }
      end
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:theme, :level, :number_of_questions, :feedback)
  end
end
