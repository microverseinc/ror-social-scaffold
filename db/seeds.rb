# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  name: 'Joseph Flores',
  email: 'yosept.flores@gmail.com',
  password: '123lol'
)

15.times do |i|
  User.create(
    name: Faker::Name.name,
    email: "user#{i}@email.com",
    password: 'password'
  )
end

def different_number(options = {})
  dif_num = Random.rand(options[:min]..options[:max])
  return dif_num if dif_num != options[:than]

  different_number(than: options[:than],min: options[:min],max: options[:max])
end

15.times do
  user = Random.rand(User.first.id..User.last.id)
  Friendship.create(
    user_id: user,
    friend_id: different_number(than:user, min: User.first.id, max:User.last.id),
    confirmed: [true, false].sample
  )
end