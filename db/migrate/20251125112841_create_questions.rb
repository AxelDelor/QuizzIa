class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question_content
      t.string :answer_content
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
