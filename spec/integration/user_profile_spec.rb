require 'rails_helper'

def log_in_with(email, password)
  visit new_user_session_path

  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

RSpec.feature 'User profile', type: :feature do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com', password: '123456') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com', password: '123456') }

  scenario 'User visits his show page' do
    log_in_with(user1.email, user1.password)
    expect(page).to have_no_css('a', text: 'Add friend')
    visit user_path(user1)
    expect(page).to have_css('h2', text: "Name: #{user1.name}")
    expect(page).to have_css('a', text: 'Check your sent friend request')
    expect(page).to have_css('h3', text: 'Recent posts:')
  end
  scenario 'User visits other user show page who is not their friend and havent sent a friend request' do
    log_in_with(user1.email, user1.password)
    visit user_path(user2)
    expect(page).to have_css('a', text: 'Add friend')
    expect(page).to have_no_css('a', text: 'Check your sent friend request')
  end
  scenario 'User visits other user show page who is not their friend and have sent a friend request to them' do
    log_in_with(user1.email, user1.password)
    user1.friendships.create(friend_id: user2.id)
    visit user_path(user2)
    expect(page).to have_css('p', text: 'You have already requested this user to be your friend')
    expect(page).to have_no_css('a', text: 'Check your sent friend request')
  end
  scenario 'User visits other user show page who is not their friend and have recieved a friend request from them' do
    log_in_with(user1.email, user1.password)
    user2.friendships.create(friend_id: user1.id)
    visit user_path(user2)
    expect(page).to have_css('p', text: 'You have a pending friend request from this user')
    expect(page).to have_no_css('a', text: 'Check your sent friend request')
  end
end
