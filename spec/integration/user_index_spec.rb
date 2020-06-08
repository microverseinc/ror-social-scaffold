require 'rails_helper'

def log_in_with(email, password)
  visit new_user_session_path

  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

RSpec.feature 'Users index', type: :feature do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com', password: '123456') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com', password: '123456') }

  scenario 'User visits event index page when logged in' do
    log_in_with(user1.email, user1.password)
    visit users_path
    users_i = User.paginate(page: 1)
    expect(page).to have_css('a', text: 'Add friend', count: 1)

    users_i.each do |user|
      expect(page).to have_css('p', text: "Name: #{user.name}")
      expect(page).to have_css('a', text: 'See Profile')
    end
  end
  scenario 'User sends a friend request and goes back to the index page' do
    log_in_with(user1.email, user1.password)
    visit users_path
    find(:xpath, ".//a[@href='/index/#{user2.id}']").click
    expect(page).to have_current_path(user_path(user2))
    expect(page).to have_css('p', text: 'You have already requested this user to be your friend')
    visit users_path
    expect(page).to have_css('p', text: 'You have already requested this user to be your friend')
  end
  scenario 'User has been sent a friend request and goes to the index pages' do
    user1.friendships.create(friend_id: user2.id)
    log_in_with(user2.email, user2.password)
    visit users_path
    expect(page).to have_css('p', text: 'You have a pending friend request from this user')
  end
end
