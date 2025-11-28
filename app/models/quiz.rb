class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions
  validates :level, :theme, :number_of_questions, presence: true
  validates :number_of_questions, numericality: { less_than_or_equal_to: 10, greater_than_or_equal_to: 1 }
  validates :level, :inclusion => {:in => %w(easy medium hard)}


  def set_feedback
    chat = RubyLLM.chat
    @questions = Question.where(quiz_id: id)
    @prompt = "You are a teacher giving a quiz to a student. Here are the questions accompanied by the correct answers, the users answers and the score for each questions."
    @questions.each_with_index do |question,index|
    @prompt += "question #{index + 1}: #{question.question_content}.correct answer: #{question.answer_content}. user's answer: #{question.user_answer}. question score: #{question.question_score}. "
    end
    @prompt += " Give just an overall feedback."
    @response = chat.ask(@prompt)
    update(feedback: @response.content)
  end

end
