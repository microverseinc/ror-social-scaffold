require 'rails_helper'

RSpec.describe 'friendship feature', type: :system do
  before(:each) do
    User.create(name: 'User001',
                email: 'user001@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')

    User.create(name: 'User002',
                email: 'user002@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')

    User.create(name: 'User003',
                email: 'user003@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')
  end

  it 'allows to invite a user to become friends from their profile' do
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    expect(page).to have_content('Invite to friendship')
  end
  it 'allows to end a previously accepted friendship' do
    Friendship.safe_create(User.first.id, User.second.id)
    Friendship.find_by(user_id: User.second.id, friend_id: User.first.id).update(status: true)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    expect(page).to have_content('End friendship')
  end
  it 'returns to default if friendship is ended' do
    Friendship.safe_create(User.first.id, User.second.id)
    Friendship.find_by(user_id: User.second.id, friend_id: User.first.id).update(status: true)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    click_link 'End friendship'
    expect(page).to have_content('Invite to friendship')
  end
  it 'allows to accept a friendship request' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    expect(page).to have_content('Accept')
  end

  it 'allows you to end friendship after accepting it' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    click_link 'Accept'
    expect(page).to have_content('End friendship')
  end

  it 'allows to reject a friendship request' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    expect(page).to have_content('Reject')
  end

  it 'returns to default after rejecting request' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    click_link 'Reject'
    expect(page).to have_content('Invite to friendship')
  end

  it 'allows to take down a friendship request you sent' do
    Friendship.safe_create(User.first.id, User.second.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    expect(page).to have_content('Remove friendship request')
  end
  it 'returns to default after taking down a friendship request you sent' do
    Friendship.safe_create(User.first.id, User.second.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    click_link 'Remove friendship request'
    expect(page).to have_content('Invite to friendship')
  end

  it 'warns you of any pending friendship requests in the navbar' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit root_path
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    expect(page).to have_content('Pending Friendship Requests'.upcase)
  end
  it 'shows you the pending request among all users when clicking the warning' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit root_path
    fill_in 'Email', with: 'user001@example.com'
    fill_in 'Password', with: 'Secret1'
    click_button 'Log in'
    click_link 'Pending Friendship Requests'
    expect(page).to have_content('Pending Friendship Request')
  end
end
