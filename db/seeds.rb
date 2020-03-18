# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times do |i|
  User.create(
    name: "user#{i}",
    email: "user#{i}@email.com",
    password: 'password'
  )
end

5.times do
  Friendship.create(
    user_id: Random.rand(1..15),
    friend_id: val=Random.rand(1..15) == :user_id ? Random.rand(1..15) : val,
    confirmed: [true, false].sample
  )
end