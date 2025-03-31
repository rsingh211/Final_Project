# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
genres = ["Hip-Hop", "Trap", "Lofi", "Drill"]
genres.each { |name| Category.create!(name:) }

10.times do |i|
  Beat.create!(
    title: "Beat #{i + 1}",
    description: "🔥 A hard-hitting #{genres[i % 4]} beat.",
    genre: genres[i % 4],
    price: rand(20..60),
    license_type: "Basic",
    category: Category.all.sample
  )
end
Page.create!(title: "About", content: "Info about Despised Beats.")
Page.create!(title: "Contact", content: "Reach us at despisedbeats@email.com.")
