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

[
  { name: "AB", pst: 0.00, gst: 0.05, hst: 0.00, qst: 0.00 },
  { name: "BC", pst: 0.07, gst: 0.05, hst: 0.00, qst: 0.00 },
  { name: "MB", pst: 0.07, gst: 0.05, hst: 0.00, qst: 0.00 },
  { name: "NB", pst: 0.00, gst: 0.00, hst: 0.15, qst: 0.00 },
  { name: "NL", pst: 0.00, gst: 0.00, hst: 0.15, qst: 0.00 },
  { name: "NS", pst: 0.00, gst: 0.00, hst: 0.15, qst: 0.00 },
  { name: "NT", pst: 0.00, gst: 0.05, hst: 0.00, qst: 0.00 },
  { name: "NU", pst: 0.00, gst: 0.05, hst: 0.00, qst: 0.00 },
  { name: "ON", pst: 0.00, gst: 0.00, hst: 0.13, qst: 0.00 },
  { name: "PE", pst: 0.00, gst: 0.00, hst: 0.15, qst: 0.00 },
  { name: "QC", pst: 0.00, gst: 0.05, hst: 0.00, qst: 0.09975 },
  { name: "SK", pst: 0.06, gst: 0.05, hst: 0.00, qst: 0.00 },
  { name: "YT", pst: 0.00, gst: 0.05, hst: 0.00, qst: 0.00 }
].each do |province|
  Province.find_or_create_by!(name: province[:name]) do |p|
    p.gst = province[:gst]
    p.pst = province[:pst]
    p.hst = province[:hst]
    p.qst = province[:qst]
  end
end
