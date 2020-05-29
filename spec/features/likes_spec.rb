require 'rails_helper'

RSpec.describe 'Liking and Disliking', type: :feature do
  before :each do
    user1 = User.create(name: 'Oscar', email: 'o@mail.com', password: '123456')
    user2 = User.create(name: 'Alexis', email: 'a@mail.com', password: '123456')
    user1.posts.create(content: 'A new post by Oscar.')
    f1 = Friendship.create(requesting_friend: user1, requested_friend: user2, status: false) # request sent
    f1.update(status: true) # request accepted

    visit user_session_path
    fill_in 'Email', with: 'a@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end

  scenario ' Like a post ' do
    click_on 'Like!'
    expect(page).to have_content('You liked a post.')
  end

  scenario ' Dislike a post ' do
    click_on 'Like!'
    click_on 'Dislike!'
    expect(page).to have_content('You disliked a post.')
  end
end
