require 'rails_helper'
RSpec.describe 'get a new friend', type: :system do
  it 'send a friend request' do
    @user = User.new(name: 'Yahir', email: 'yahir@example.com', password: 'password')
    @user.save
    @user2 = User.new(name: 'mauricio', email: 'mauricio@example.com', password: 'password')
    @user2.save
    visit new_user_session_path
    fill_in 'user[email]', with: 'yahir@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
    visit users_path
    click_link('Add')
    expect(page).to have_content('You send a friend request.')
  end

  it 'accept friend request' do
    @user = User.new(name: 'Yahir', email: 'yahir@example.com', password: 'password')
    @user.save
    @user2 = User.new(name: 'mauricio', email: 'mauricio@example.com', password: 'password')
    @user2.save
    visit new_user_session_path
    fill_in 'user[email]', with: 'yahir@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
    visit users_path
    click_link 'Add'
    click_on 'Sign out'
    sleep(3)
    visit user_session_path
    fill_in 'user[email]', with: 'mauricio@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
    visit friendships_path
    click_on 'accept friend request'
    expect(page).to have_content('You confirmed a friend request.')
  end

  scenario 'reject friend request' do
    @user = User.new(name: 'Yahir', email: 'yahir@example.com', password: 'password')
    @user.save
    @user2 = User.new(name: 'mauricio', email: 'mauricio@example.com', password: 'password')
    @user2.save
    visit new_user_session_path
    fill_in 'user[email]', with: 'yahir@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
    visit users_path
    click_link 'Add'
    click_on 'Sign out'
    sleep(3)
    visit user_session_path
    fill_in 'user[email]', with: 'mauricio@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
    visit friendships_path
    click_on 'reject friend request'
    expect(page).to have_content('You reject a friend request.')
  end
end
