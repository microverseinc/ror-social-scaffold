def log_in_with(email, password)
  visit new_user_session_path

  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

RSpec.feature 'Posts', type: :feature do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com', password: '123456') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com', password: '123456') }
  let!(:user3) { User.create(name: 'test3', email: 'test3@email.com', password: '123456') }

  scenario 'User visits the time line and can only see his friends posts' do
    user2.posts.create(content: 'User 2')
    user3.posts.create(content: 'User 3')
    user1.friendships.create(friend_id: user2)

    log_in_with(user1.email, user1.password)
    visit posts_path
    friend_ids = user1.friends.map { |a| a.friend.id }
    posts = Post.where(user_id: user1.id).or(Post.where(user_id: friend_ids)).paginate(page: 1)

    posts.each do |post|
      expect(page).to have_css('a', text: "Name: #{post.user.name}")
      expect(page).to have_css('p', text: post.content)
    end
  end
end
