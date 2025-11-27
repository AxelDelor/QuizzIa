Question.destroy_all
Quiz.destroy_all

quiz = Quiz.create(theme: "coffee", level: "medium", number_of_questions: 3, user_id: 1, feedback: "Not bad, you're no beginner, but there's still room for improvement. I recommend doing some further reading. Here is a list of resources for you:")
Question.create(question_content: "Quel est le pays d'origine du café ?", answer_content: "Éthiopie", quiz_id: quiz.id, question_score: 100, user_answer: "éthiopie")
Question.create(question_content: "Comment s'appelle le processus de torréfaction du café ?", answer_content: "Torréfaction", quiz_id: quiz.id, question_score: 0, user_answer: "La cuite")
Question.create(question_content: "Quelle est la différence principale entre un espresso et un café filtre ?", answer_content: "L'intensité et la méthode d'extraction", quiz_id: quiz.id, question_score: 50, user_answer: "L'intensité")
