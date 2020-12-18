require 'rails_helper'

RSpec.describe "Friend Requests ", type: :feature do

  before do
    @user = create(:user)
    @user2 = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  it 'Checks Availability to send Friend Request' do
    visit users_path
    expect(page).to have_content('See Profile')
    expect(page).to have_content('Send friendship invitation')
  end

  it 'Sends a Friend Request from the User\'s list' do
    visit users_path
    click_link 'Send friendship invitation'
    expect(page).to have_content('Friendship request sent')
    expect(page).to have_content('You already sent an invitation')
  end

  it 'Send a Friend Request from the User\'s personal page' do
    visit user_path(@user2)
    click_link 'Send friendship invitation'
    expect(page).to have_content('Friendship request sent')
    expect(page).to have_content('You already sent an invitation')
  end

  it 'Reject a friend request' do
    visit users_path
    click_link 'Send friendship invitation'
    expect(page).to have_content('Friendship request sent')
    expect(page).to have_content('You already sent an invitation')
    click_link('Sign out')
    visit new_user_session_path
    fill_in 'Email', with: @user2.email
    fill_in 'Password', with: @user2.password
    click_button 'Log in'
    visit friendships_path
    click_link('Accept invitation')
    expect(page).to have_content('Friend Added')
  end
end