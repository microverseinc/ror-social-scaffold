require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before :each do
    @user1 = User.create!(name: 'User1', email: 'user1@email.com', password: '123456')
    @user2 = User.create!(name: 'User2', email: 'user2@email.com', password: '123456')
  end

  scenario 'user 1 logs in and sends invitation then user 2 accepts it' do
    visit new_user_session_path
    fill_in 'Email', with: 'user1@email.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    click_button 'send invitation'
    click_link 'Sign out'

    visit new_user_session_path
    fill_in 'Email', with: 'user2@email.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_selector(:link_or_button, 'Accept')
    expect(page).to have_selector(:link_or_button, 'Decline')
    click_button 'Accept'
  end
end
