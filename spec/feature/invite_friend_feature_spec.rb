require 'rails_helper'

RSpec.describe 'Invite friend', type: :feature do
  before(:each) do
    User.create(id: 1, email: 'user@email.com', password: 'password', name: 'user')
    User.create(id: 2, email: 'user2@email.com', password: 'password', name: 'user2')
    Friendship.create(user_id: 1, friend_id: 2, status: false)
  end

  it 'Verify if there is a pending invitation on users#index page' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    visit '/users'
    expect(page).to have_content 'Pending'
  end

  it 'Verify if User accepted the invitation' do
    Friendship.update(user_id: 1, friend_id: 2, status: true)

    visit '/users/sign_in'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    visit '/users'
    expect(page).to have_content 'Friends'
  end

  it 'Verify if User declined the invitation' do
    friend = Friendship.find([1, 2])
    friend.delete

    visit '/users/sign_in'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    visit '/users'

    expect(page).to have_button 'Add Friend'
  end

  it 'Verify invitation button on profile page' do
    friend = Friendship.find([1, 2])
    friend.delete

    visit '/users/sign_in'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    visit '/users/2'

    expect(page).to have_button 'Add Friend'
  end
end
