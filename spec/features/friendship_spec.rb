require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before :each do
    @user1 = User.create!(name: 'gurbuz', email: 'gurbuz@email.com', password: '123456')
    @user2 = User.create!(name: 'kalu', email: 'kalu@email.com', password: '123456')
  end

  scenario 'user 1 logs in and sends invitation then user 2 accepts it' do
    visit new_user_session_path
    fill_in 'email', with: 'gurbuz@email.com'
    fill_in 'password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    click_link 'add_friend'
    click_link 'Sign out'

    visit new_user_session_path
    fill_in 'email', with: 'kalu@email.com'
    fill_in 'password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_selector(:link_or_button, 'Accept Request')
    expect(page).to have_selector(:link_or_button, 'Reject Request')
    click_link 'accept_request'
  end
end
