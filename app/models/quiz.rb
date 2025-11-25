class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions
  validates :level, :theme, :number_of_questions, presence: true
  validates :number_of_questions, numericality: { less_than_or_equal_to: 10, greater_than_or_equal_to: 1 } 
  validates :level, :inclusion => {:in => %w(easy medium hard)}
end
