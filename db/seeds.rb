# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# rubocop:disable Layout/LineLength
u1 = User.create(name: 'Luke Theo', email: 'b.email@example.com', password: 'secretpass', password_confirmation: 'secretpass')
u2 = User.create(name: 'Mak Saro', email: 'k.email@example.com', password: 'secretpass', password_confirmation: 'secretpass')
# rubocop:enable Layout/LineLength

# rubocop:disable Lint/UselessAssignment
f1 = Friendship.create(user_id: u1.id, confirmed: false)
f2 = Friendship.create(user_id: u2.id, confirmed: false)
# rubocop:enable Lint/UselessAssignment
