# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# puts "Creating theme..."
# vache = Theme.create!(name: "Vache")

Quiz.create(
  theme: "Vache",
  level: "medium",
  number_of_questions: 3,
  user_id: 1,
)

Quiz.create(
  theme: "Sports",
  level: "hard",
  number_of_questions: 8,
  user_id: 1,
)

Quiz.create(
  theme: "Animal",
  level: "easy",
  number_of_questions: 10,
  user_id: 1,
)