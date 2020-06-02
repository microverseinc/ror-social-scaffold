# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'test1',
             email: 'test1@email.com',
             password: '123456')

99.times do |n|
  name = "test#{n + 2}"
  email = "test#{n + 2}@email.com"
  password = '123456'
  User.create!(name: name,
               email: email,
               password: password)
end

users = User.order(:created_at).take(6)

10.times do |n|
  users.each do |user|
    content = Faker::Date.between(from: 2.days.ago, to: 2.days.from_now)
    location = "#{user.name}'s house #{n + 1}"
    user.created_events.create!(date: date, location: location)
  end
end

events = Event.all

events.each do |event|
  users.each do |user|
    user.attended_events << event
  end
end
