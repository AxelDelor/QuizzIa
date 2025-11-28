Question.destroy_all
Quiz.destroy_all
User.destroy_all
user = User.create(email: "test@test.com", password: "password")
puts "utilisateur créé avec succès !!"


def create_quiz(theme, user)
  quiz = Quiz.new
  quiz.user = user
  quiz.number_of_questions = 3
  quiz.level = "easy"
    quiz.theme = theme
    chat = RubyLLM.chat
    response = chat.ask("create a questionnaire with #{quiz.number_of_questions} questions and their answers on the subject of #{theme},  the questionnaire should have a difficulty level of #{quiz.level} please give your response in the format of a array of hash that I can parse with JSON.parse : [ { 'question': 'What is the capital of France?', 'reponse': 'Paris' }, { 'question': 'what is the sum of 2 and 2', 'reponse': '4'}, { 'question': 'Who wrote 'Ulysses'?', 'reponse': 'James Joyce' } ]. do not add any linebreak in your response")
    quiz.save
    quiz_content = JSON.parse(response.content)

    quiz_content.each do |item|
      question = item["question"]
      reponse = item["reponse"]
      q = Question.create(question_content: question, answer_content: reponse, quiz: quiz, user_answer: reponse, question_score: 100)
      calcul_score(q)
    end
end

def calcul_score(question)
  chat = RubyLLM.chat
    response = chat.ask("You are a teacher giving a quiz to a student. Here is the question: #{question.question_content} Here is the correct answer: #{question.answer_content} Here is the student’s answer: #{question.user_answer} In your response please give a grade between 0 and 100 based on the accuracy of their response. Only give an integer.")
    score = response.content.to_i
    question.question_score = score

    if question.quiz.questions.last == question
      question.quiz.set_feedback
    end
end
create_quiz("vache", User.first)
