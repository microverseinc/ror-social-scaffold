# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "ivancito",
             email: "ivancito@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar")

            
20.times do |n|
  name  = Faker::Name.name[0..19]
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

users = User.order(:created_at).take(6)
count = 1
users.each do |user|
  content = Faker::Lorem.sentence(5) + " #{count}"
  user.posts.create!(content: content)
  count = count + 1
end

user_to_add_friends = User.find(4)
users = User.order(:id).take(3)
users.each do |user|
  user_to_add_friends.requested_friends << user
end
user_to_add_friends.friendships.each do |friendship|
  friendship.status = true
  friendship.save
end