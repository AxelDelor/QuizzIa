class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!
def new 
  @quiz = Quiz.new
end

def create
  @quiz = Quiz.new(quiz_params)
  @quiz.save
end

private

def quiz_params
  params.require(:quiz).permit(:theme, :level, :number_of_questions, :feedback)
end
end
