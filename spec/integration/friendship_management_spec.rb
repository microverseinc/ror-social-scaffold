require 'rails_helper'

RSpec.describe 'Friendship management', type: :feature do
  let(:user) { User.create(name: 'Bekhzod', email: 'example@gmail.com', password: '12345677') }
  let(:friend) { User.create(name: 'Javiar', email: 'javiar@gmail.com', password: '12345677') }

  scenario 'Send friend request from Users index page' do
    friend = User.create(name: 'Beka', email: 'bekhzod@gmail.com', password: '1234567')
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')

    click_on 'All users'
    sleep(3)
    expect(page).to have_content(friend.name)
    expect(page).to have_link('Add friend')

    first('.item>a').click # Click on the first 'Add friend' button
    sleep(3)
    expect(page).to have_content('Friends request has been sent')
  end

  scenario 'Accept friendship' do
    user.friendships.build(friend_id: friend.id).save
    visit root_path
    fill_in 'user_email', with: friend.email
    fill_in 'user_password', with: friend.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
    click_on 'All users'
    sleep(3)
    expect(page).to have_link('Accept')
    expect(page).to have_link('Reject')

    click_link('Accept')
    sleep(3)
    expect(page).to have_content('You have been accepted friendship')
  end

  scenario 'Reject friendship' do
    user.friendships.build(friend_id: friend.id).save
    visit root_path
    fill_in 'user_email', with: friend.email
    fill_in 'user_password', with: friend.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
    click_on 'All users'
    sleep(3)
    expect(page).to have_link('Accept')
    expect(page).to have_link('Reject')

    click_link('Reject')
    sleep(3)
    expect(page).to have_content('Friendship request rejected Successfully')
  end

  scenario 'See posts from the user and his or her friends in the Timeline' do
    friend.posts.build(content: 'Hello Bekhzod').save
    user.posts.build(content: 'Hello Javiar').save
    user.friendships.build(friend_id: friend.id, confirmed: true).save

    visit root_path
    fill_in 'user_email', with: friend.email
    fill_in 'user_password', with: friend.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
    click_on 'Timeline'
    sleep(3)
    expect(page).to have_content(user.name)
    expect(page).to have_content('Hello Bekhzod')
    expect(page).to have_content(friend.name)
    expect(page).to have_content('Hello Javiar')
  end
end