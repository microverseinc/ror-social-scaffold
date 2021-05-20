require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before :each do
    @user1 = User.create!(name: 'user1', email: 'user1@example.com', password: 'password')
    @user2 = User.create!(name: 'user2', email: 'user2@example.com', password: 'password')
  end

  scenario 'fisrt user logs in and sends invitation then the second user accepts it' do
    visit new_user_session_path
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    click_button 'Add Friend'
    click_link 'Sign out'

    visit new_user_session_path
    fill_in 'Email', with: 'user2@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_selector(:link_or_button, 'Accept')
    expect(page).to have_selector(:link_or_button, 'Decline')
    click_button 'Accept'
  end

  scenario 'user logs in and see his posts as well as his friends posts in the homepage' do
    visit root_path
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
  end
end
