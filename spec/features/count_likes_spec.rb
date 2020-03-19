require 'rails_helper'

RSpec.feature 'CountLikes', type: :feature do
  3.times do |i|
    let("user#{i + 1}") do
      User.create(name: "user#{i + 1}",
                  email: "user#{i + 1}@email.com",
                  password: 'foobar',
                  password_confirmation: 'foobar')
    end
  end

  let(:friendship) { Friendship.create(user_id: user1.id, friend_id: user2.id, confirmed: true) }
  let(:friendship_inverse) { Friendship.create(user_id: user2.id, friend_id: user1.id, confirmed: true) }

  scenario 'User 1 creates post and User 2 and 3 likes it' do
    log_in(user1)
    expect(page).to have_selector(:link_or_button, 'Save')
    fill_in 'post_content', with: 'This is a new test post'
    click_button 'Save'
    expect(page).to have_content('0 likes!')
    click_link('Sign out')
    friendship
    friendship_inverse
    log_in(user2)
    expect(page).to have_content('user1')
    click_link('Like!')
    expect(page).to have_content('1 likes!')
  end

  def log_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
