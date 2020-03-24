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

70.times do |i|
  User.create(
    name: Faker::DcComics.hero,
    email: "user#{i}@email.com",
    password: 'password'
  )
end

120.times do
  user = User.find(Random.rand(User.first.id..User.last.id))
  post = user.posts.build(content: Faker::ChuckNorris.fact)
  post.save
end


def different_number(options = {})
  dif_num = Random.rand(options[:min]..options[:max])
  return dif_num if dif_num != options[:than]
  
  different_number(than: options[:than],min: options[:min],max: options[:max])
end

def uniqueFriend
  user = Random.rand(User.first.id..User.last.id)
  friend = different_number(than:user, min: User.first.id, max:User.last.id)
  
  if Friendship.same_friendship(user,friend).any?
    uniqueFriend
  else
    Friendship.create(user_id: user, friend_id: friend)
  end
end

150.times do
  uniqueFriend
end