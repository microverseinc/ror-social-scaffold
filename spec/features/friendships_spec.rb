require 'rails_helper'

RSpec.describe 'Friendship Features', type: :feature do
  let(:user1) { User.new(id: 234, name: 'John', email: 'john@test.com', password: 'password123') }
  let(:user2) { User.new(id: 675, name: 'Jane', email: 'jane@test.com', password: 'passjane12') }
  let(:friendship) { Friendship.new(user_id: user1.id, friend_id: user2.id) }

  scenario 'user can send a request' do
    user1.save
    user2.save
    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'
    visit users_path
    click_link 'Add Friend', class: 'friend'
    expect(page).to have_content('Friendship Created')
  end

  scenario 'user can see profile page of ' do
    user1.save
    user2.save
    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'
    visit users_path
    click_link 'See Profile', match: :first
    expect(page).to have_content('Recent posts')
  end
  scenario 'user can cancel sent request' do
    user1.save
    user2.save
    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'
    visit users_path
    click_link 'Add Friend', class: 'friend'
    visit users_path
    click_link 'Cancel Request'
    expect(page).to have_content('Friendship Canceled')
  end
  scenario 'user can accept requests sent to him' do
    user1.save
    user2.save
    friendship.save
    visit new_user_session_path
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button 'Log in'
    click_link user2.name.to_s
    click_link 'Accept'
    expect(page).to have_content('Friendship Accepted')
  end
  scenario 'users can unfriend ' do
    user1.save
    user2.save
    friendship.save
    visit new_user_session_path
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button 'Log in'
    click_link user2.name.to_s
    click_link 'Accept'
    click_link user2.name.to_s
    click_link 'Un-friend'
    expect(page).to have_content('Friendship Canceled')
  end
  scenario ' inverse friendship is reflected when a request is accepted' do
    user1.save
    user2.save
    friendship.save
    visit new_user_session_path
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button 'Log in'
    click_link user2.name.to_s
    click_link 'Accept'
    click_link 'Sign out'
    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'
    click_link user1.name.to_s
    expect(page).to have_content(user2.name.to_s)
  end
end
