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

user = User.first

10.times do |n|
  if user.id != n + 1
    friend = n + 1
    user.friendships.create(friend_id: friend)
  end
end
