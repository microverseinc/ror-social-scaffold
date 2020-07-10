require "faker"

User.create(
  {
    name: "julio",
    email: "julio@julio.com",
    password: 123_456,
    password_confirmation: 123_456,
  }
)

User.create(
  {
    name: "felipe",
    email: "felipe@felipe.com",
    password: 123_456,
    password_confirmation: 123_456,
  }
)

10.times do
  User.create(
    {
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: "123456",
      password_confirmation: "123456",
    }
  )
end

# User.all.each do |user|
#   friendable = User.all.ids
#   3.times do
#     friend_id = friendable.delete(rand(0..User.all.length))
#     Friendship.create({ user_id: user.id, friend_id: friend_id })
#   end
# end
