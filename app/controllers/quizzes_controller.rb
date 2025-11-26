
class QuizzesController < ApplicationController

  def new 
    @quiz = Quiz.new
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user = current_user
    @number_of_questions = @quiz.number_of_questions
    @level = @quiz.level
    @theme = @quiz.theme
    chat = RubyLLM.chat
    @response = chat.ask("create a questionnaire with #{@number_of_questions} questions and their answers on the subject of #{@theme},  the questionnaire should have a difficulty level of #{@level} please give your response in the format of a array of hash that I can parse with JSON.parse : [ { 'question': 'Quelle est la capitale de la France ?', 'reponse': 'Paris' }, { 'question': 'Combien font 2 + 2 ?', 'reponse': '4'}, { 'question': 'Qui a écrit 'Le Petit Prince' ?', 'reponse': 'Antoine de Saint-Exupéry' } ]. do not add any linebreak in your response")
    @quiz.save
    @quiz_content = JSON.parse(@response.content)
    
    @quiz_content.each do |item|
      question = item["question"]
      reponse = item["reponse"]
      Question.create(question_content: question, answer_content: reponse, quiz_id: @quiz.id)
    end
    redirect_to quiz_path(@quiz)
  end

  private

  def quiz_params
    params.require(:quiz).permit(:theme, :level, :number_of_questions, :feedback)
  end
end
