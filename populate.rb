def populate_users(number_of_users)
  (1..number_of_users + 1).each do |n|
    User.create(
      name: "User#{n}",
      email: "user#{n}@example.com",
      password: '123456',
      password_confirmation: '123456'
    )
  end
end

def populate_user_posts(number_of_users)
  all_users = User.all
  (1..number_of_users + 1).each do |n|
    user = User.find(n)
    all_users.each do |user_to_greet|
      next if user.name == user_to_greet.name

      post = user.posts.build(content: "Hello, #{user_to_greet.name}!")
      post.save
    end
  end
end

populate_users(10)
populate_user_posts(10)
