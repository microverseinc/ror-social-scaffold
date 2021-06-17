# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |index|
    User.create(name: "Doe#{index}", email: "doe#{index}@gamil.com", password: "#{index}123456", password_confirmation: "#{index}123456")
end
