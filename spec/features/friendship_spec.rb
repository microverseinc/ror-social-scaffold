require 'rails_helper'

RSpec.describe 'the signin process', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'send friend request' do
    user1 = User.create(name: 'ari5', email: 'testuser1@email.com', password: '123456')
    User.create(name: 'ari6', email: 'testuser2@email.com', password: '123456')
    visit root_path
    click_link_or_button 'Sign in'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    visit users_path
    click_button 'Send request'
    expect(page).to have_text('Friend request sended')
  end
  it 'can not see button when already sent' do
    user1 = User.create(name: 'ari5', email: 'testuser1@email.com', password: '123456')
    User.create(name: 'ari6', email: 'testuser2@email.com', password: '123456')
    visit root_path
    click_link_or_button 'Sign in'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    visit users_path
    click_button 'Send request'
    expect(page).to have_text('Friend request sended')
    visit users_path
    expect(page).not_to have_text('Send request')
  end

  it 'Confirm friend request' do
    user1 = User.create(name: 'ari5', email: 'testuser1@email.com', password: '123456')
    user2 = User.create(name: 'ari6', email: 'testuser2@email.com', password: '123456')
    visit root_path
    click_link_or_button 'Sign in'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    visit users_path
    click_button 'Send request'
    expect(page).to have_text('Friend request sended')
    click_link 'Sign out'
    fill_in 'user[email]', with: user2.email
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    visit users_path
    click_link 'Confirm'
    expect(page).to have_text('Friend request accepted')
  end

  it 'Deny friend request' do
    user1 = User.create(name: 'ari5', email: 'testuser1@email.com', password: '123456')
    user2 = User.create(name: 'ari6', email: 'testuser2@email.com', password: '123456')
    visit root_path
    click_link_or_button 'Sign in'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    visit users_path
    click_button 'Send request'
    expect(page).to have_text('Friend request sended')
    click_link 'Sign out'
    fill_in 'user[email]', with: user2.email
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    visit users_path
    click_link 'Deny'
    expect(page).to have_text('You have denied the friendship request')
  end
end
