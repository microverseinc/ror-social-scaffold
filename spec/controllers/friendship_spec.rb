require 'rails_helper'

RSpec.describe 'Friendship', type: :feature do
  let(:user) do
    User.create(name: 'mytest1', email: 'testing@gmail.com',
                password: 'testing', password_confirmation: 'testing')
  end
  let(:testuser) do
    User.create(name: 'mytest2', email: 'testing2@gmail.com',
                password: 'testing', password_confirmation: 'testing')
  end

  scenario 'add friend' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
    click_link('All users')
    expect(page).to have_content 'See Profile'
  end

  scenario 'negative login case' do
    visit new_user_session_path
    fill_in 'user_email', with: 'dada@gmail.com'
    fill_in 'user_password', with: 'password123'
    click_button 'Log in'
    expect(page).not_to have_content('Signed in successfully')
  end

  scenario 'remove friend' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
    click_link('All users')
    click_on('See Profile', match: :first)
    click_on('Sign out')
    visit new_user_session_path
    fill_in 'user_email', with: testuser.email
    fill_in 'user_password', with: testuser.password
    click_button 'Log in'
    click_link('All users')
    click_link('Add Friend', match: :first)
    expect(page).to have_content 'Delete Request'
  end
end
