# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.feature 'FriendShipFlows', type: :feature do
  before :each do
    @user = User.create!(name: 'Diego Lira', email: 'diego@lira.com', password: '123123')
    @friend = User.create!(name: 'Laura Lira', email: 'laura@saldanha.com', password: '123123')
  end
  scenario 'user 1 logs in and sends invitation than user 2 accepts it' do
    visit new_user_session_path
    fill_in 'email', with: 'diego@lira.com'
    fill_in 'password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    click_button 'Invite to friendship'
    expect(page).to have_selector(:link_or_button, 'Undo Request')
    click_link 'Sign out'

    visit new_user_session_path
    fill_in 'email', with: 'laura@saldanha.com'
    fill_in 'password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_selector(:link_or_button, 'Accept Request')
    expect(page).to have_selector(:link_or_button, 'Decline Request')
    click_button 'Accept Request'
    expect(page).to have_selector(:link_or_button, 'Undo friendship')
  end

  scenario 'user 1 logs in and sends invitation than user 2 declines it' do
    visit new_user_session_path
    fill_in 'email', with: 'diego@lira.com'
    fill_in 'password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    click_button 'Invite to friendship'
    expect(page).to have_selector(:link_or_button, 'Undo Request')
    click_link 'Sign out'

    visit new_user_session_path
    fill_in 'email', with: 'laura@saldanha.com'
    fill_in 'password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_selector(:link_or_button, 'Accept Request')
    expect(page).to have_selector(:link_or_button, 'Decline Request')
    click_button 'Decline Request'
    expect(page).to have_selector(:link_or_button, 'Invite to friendship')
  end
end
# rubocop:enable Metrics/BlockLength
