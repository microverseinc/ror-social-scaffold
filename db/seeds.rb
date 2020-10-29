# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a main sample user.
User.create!(name: "Sunday Ezeilo", email: "chezsunnez@gmail.com", password: "foobar")
User.create!(name: "Example User", email: "example@railstutorial.org", password: "foobar")

# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password)
end

# Generate posts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(content: content) }
end

# Friends send friend requests to user.
users = User.all
friend = users.first
users[2..80].each { |user| user.send_request(friend.id) }

# User accepts friend requests
user = User.find(1)
user.friend_requests[2..40].each { |friend| user.accept_friend(friend.id) }

# User sends friend requests to other friends
users = User.all
user = users.first
friends = users[81..98]
friends.each { |friend| user.send_request(friend.id) }

# Other users accept user's friend request
users = User.all
friend = users.first
users = users[81..89]
users.each { |user| user.accept_friend(friend.id) }

