require 'rails_helper'
RSpec.describe 'Testing Friendship', type: :feature do
  before(:each) do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass',
                password_confirmation: 'secretpass')
    User.create(name: 'Eze Promise', email: 'e.email@example.com', password: 'password',
                password_confirmation: 'password')
    visit visit new_user_session_path
    fill_in 'user_email', with: 'e.email@example.com'
    fill_in 'user_password', with: 'password'
    find("input[type='submit']").click

    visit users_path
    expect(page).to have_content('Ibe Precious')
    expect(page).to have_content('Eze Promise')
  end

  it 'Should Add friend from any of the users listed' do
    click_link('Add friend', match: :first)
    expect(page).to have_content('You have sent a friendship request!')
    expect(page).to have_content('Pending Request')
  end

  it 'Can Accept a friend request' do
    click_link('Add friend', match: :first)
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    find("input[type='submit']").click
    visit users_path
    click_on 'Accept'
    expect(page).to have_content('You are now friends')
  end

  it 'Can Reject a friend request' do
    click_link('Add friend', match: :first)
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    find("input[type='submit']").click
    visit users_path
    click_on 'Reject'
    expect(page).to have_content('Friend has been removed')
  end
  it 'Can Unfriend an existing friend' do
    click_link('Add friend', match: :first)
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    find("input[type='submit']").click
    visit users_path
    click_on 'Accept'
    click_on 'Sign out'
    visit visit new_user_session_path
    fill_in 'user_email', with: 'e.email@example.com'
    fill_in 'user_password', with: 'password'
    find("input[type='submit']").click
    visit users_path
    click_on 'Unfriend'
    expect(page).to have_content('Friend has been removed')
  end
end
