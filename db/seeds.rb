# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

100.times do
  full_name = Faker::Name.first_name + ' ' + Faker::Name.last_name
  user = User.new(name: full_name, email: Faker::Internet.email, password: 'password')
  user.save
end

100.times do
  post = Post.new
  post.user = User.all.sample
  post.content = Faker::Lorem.sentence(word_count: [30, 35, 40, 45, 50, 55, 60, 65, 70, 75].sample)
  post.save
end

300.times do
  comment = Comment.new
  comment.user = User.all.sample
  comment.post = Post.all.sample
  comment.content = Faker::Lorem.sentence(word_count: [20, 25, 30, 35, 40, 45, 50].sample)
  comment.save
end

400.times do
  like = Like.new
  like.post = Post.all.sample
  like.user = User.all.sample
  like.save
end

200.times do
  friendship = Friendship.new(user: User.all.sample, friend: User.all.sample)
  friendship.status = Friendship::STATUSES.sample
  friendship.save if friendship.valid?
end
