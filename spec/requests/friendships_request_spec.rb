require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  before :each do
    User.create(name: 'John', email: 'john@example.com', password: 'password')
    User.create(name: 'Jane', email: 'jane@example.com', password: 'password')
  end

  scenario 'Send friendship invite' do
    visit new_user_session_path
    fill_in 'Email', with: 'John@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Add friend'
    expect(page).to have_content('You have successfuly sent a friend request')
  end

  scenario 'Confirm friend request' do
    visit new_user_session_path
    fill_in 'Email', with: 'John@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Add friend'
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'Email', with: 'jane@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Confirm'
    expect(page).to have_content('John has been added to your friends')
  end

  scenario 'Decline friend request' do
    visit new_user_session_path
    fill_in 'Email', with: 'John@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Add friend'
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'Email', with: 'jane@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Decline'
    expect(page).to have_content('You declined the request!')
  end
end
