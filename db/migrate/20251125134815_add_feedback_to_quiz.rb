class AddFeedbackToQuiz < ActiveRecord::Migration[7.1]
  def change
    add_column :quizzes, :feedback, :string
  end
end
