# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

# User.destroy_all
15.times do
  User.create!(name: Faker::Name.unique.name[1..15],
               email: Faker::Internet.unique.email, password: '123456',
               password_confirmation: '123456')
end

p 'Users created Successfully'
