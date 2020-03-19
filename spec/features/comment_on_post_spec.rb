require 'rails_helper'

RSpec.feature 'CommentPosts', type: :feature do
  2.times do |i|
    let("user#{i + 1}") do
      User.create(name: "user#{i + 1}",
                  email: "user#{i + 1}@email.com",
                  password: 'foobar',
                  password_confirmation: 'foobar')
    end
  end

  let(:friendship) { Friendship.create(user_id: user1.id, friend_id: user2.id, confirmed: true) }
  let(:friendship_inverse) { Friendship.create(user_id: user2.id, friend_id: user1.id, confirmed: true) }

  scenario "User 2 comments on User 1's post" do
    log_in(user1)
    fill_in 'post_content', with: 'This is a test post'
    click_button 'Save'
    click_link('Sign out')
    friendship
    friendship_inverse
    log_in(user2)
    expect(page).to have_content('user1')
    fill_in 'comment_content', with: 'This is a new test comment'
    click_button('Comment')
    expect(page).to have_content('This is a new test comment')
  end

  def log_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
