class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :theme
      t.string :level
      t.integer :number_of_questions
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
