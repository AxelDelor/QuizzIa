
class QuizzesController < ApplicationController
    skip_before_action :authenticate_user!
  def new 
    @quiz = Quiz.new
    @response = nil
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @number_of_questions = @quiz.number_of_questions
    @level = @quiz.level
    @theme = @quiz.theme
    chat = RubyLLM.chat
    @response = chat.ask("create a questionnaire with #{@number_of_questions} questions and their answers on the subject of #{@theme},  the questionnaire should have a difficulty level of #{@level} please give your response in the format of a array of hash [
  {
    question: 'Quelle est la capitale de la France ?',
    reponse:  'Paris'
  },
  {
    question: 'Combien font 2 + 2 ?',
    reponse:  '4'
  },
  {
    question: 'Qui a écrit 'Le Petit Prince' ?',
    reponse:  'Antoine de Saint-Exupéry'
  }
] ne rajoute pas de saut de ligne /n")
    raise
    @quiz.save
  end

  private

  def quiz_params
    params.require(:quiz).permit(:theme, :level, :number_of_questions, :feedback)
  end
end
