class AddQuestionScoreAndUserAnswerToQuestion < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :question_score, :integer
    add_column :questions, :user_answer, :string
  end
end
