require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Friendships', type: :feature do
  before :each do
    @user_one = User.create(name: 'Emma', email: 'emma@mail.com', password: '123456')
    @user_two = User.create(name: 'Alex', email: 'alex@mail.com', password: '123456')
    @user_three = User.create(name: 'Lucas', email: 'lucas@mail.com', password: '123456')
    @friendship = Friendship.create(user_id: @user_three.id, friend_id: @user_one.id, status: nil)
  end

  it 'requests friendship to another user' do
    visit user_session_path
    fill_in 'user[email]', with: @user_two.email
    fill_in 'user[password]', with: @user_two.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    click_on 'All users'
    expect(page).to have_content('Name: Emma')
    find('.button_to', match: :first).click_button 'Invite to friendship'
    expect(page).to have_content('Pending Response')
  end

  it 'accepts friendship from another user' do
    visit user_session_path
    fill_in 'user[email]', with: @user_one.email
    fill_in 'user[password]', with: @user_one.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    click_on 'All users'
    expect(page).to have_content('Name: Lucas')
    click_button 'Accept Friendship'
    expect(page).to have_content('Friendship has been accepted')
  end

  it 'deletes friendship request from another user' do
    visit user_session_path
    fill_in 'user[email]', with: @user_one.email
    fill_in 'user[password]', with: @user_one.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    click_on 'All users'
    expect(page).to have_content('Name: Lucas')
    click_button 'Reject Friendship'
    expect(page).to have_content('Friendship has been rejected')
  end
end
# rubocop:enable Metrics/BlockLength
