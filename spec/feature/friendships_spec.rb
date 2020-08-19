require 'rails_helper'

RSpec.describe 'Friendship request', type: :feature do
  before(:each) do
    User.create(name: 'maggie',
                email: 'maggie@gmail.com',
                password: 'foobar',
                password_confirmation: 'foobar')

    User.create(name: 'mary',
                email: 'mary@gmail.com',
                password: 'footbar',
                password_confirmation: 'footbar')
    visit new_user_session_path
    fill_in 'user_email', with: 'maggie@gmail.com'
    fill_in 'user_password', with: 'foobar'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'Add Friend' do
    visit users_path
    click_on 'Add Friend'
    expect(page).to have_content('Friend invitation sent')
  end

  scenario 'accept invite' do
    visit users_path
    click_on 'Add Friend'
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user_email', with: 'mary@gmail.com'
    fill_in 'user_password', with: 'footbar'
    click_button 'Log in'
    visit users_path
    click_on 'Accept'
    expect(page).to have_content('friend accepted')
  end

  scenario 'Reject invite' do
    visit users_path
    click_on 'Add Friend'
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user_email', with: 'mary@gmail.com'
    fill_in 'user_password', with: 'footbar'
    click_button 'Log in'
    visit users_path
    click_on 'Decline'
  end

  scenario 'Remove Friend' do
    visit users_path
    click_on 'Add Friend'
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user_email', with: 'mary@gmail.com'
    fill_in 'user_password', with: 'footbar'
    click_button 'Log in'
    visit users_path
    click_on 'Accept'
    expect(page).to have_content('friend accepted')
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user_email', with: 'maggie@gmail.com'
    fill_in 'user_password', with: 'foobar'
    click_button 'Log in'
    visit users_path
    click_on 'Remove friend'
  end
end
