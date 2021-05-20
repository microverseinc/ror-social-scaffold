require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before :each do
    @user = User.create!(name: 'user', email: 'user@example.com', password: 'password')
    @pal = User.create!(name: 'pal', email: 'pal@example.com', password: 'password')
  end

  scenario 'user logs in and both their posts and their friends in the homepage' do
    visit root_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
  end

  scenario 'visits all users page' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit users_path
    expect(page).to have_text('user')
    expect(page).to have_link('See Profile')
  end

  scenario 'sends an invite to friendship to pal' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit users_path
    expect(page).to have_link('Add Friend')
    click_link 'Add Friend'
    # expect(page).to have_link('Status: Invite Sent')
  end
end
