require 'rails_helper'

RSpec.describe 'Friendship management', type: :feature do
  let(:sender) { User.create(name: 'Eugenia', email: 'eugenia@gmail.com', password: '123456') }
  let(:reciever) { User.create(name: 'Anita', email: 'anita@gmail.com', password: '123456') }

  scenario 'Send friend request from Users index page' do
    reciever = User.create(name: 'Anita', email: 'anita@gmail.com', password: '123456')
    visit root_path
    fill_in 'user_email', with: sender.email
    fill_in 'user_password', with: sender.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')

    click_on 'All users'
    sleep(3)
    expect(page).to have_content("Name: #{reciever.name}")
    expect(page).to have_button('Add friend')

    first('.btn-secondary').click # Click on the first 'Add friend' button
    sleep(3)
    expect(page).to have_content('Friend request was successfully sent.')
  end

  scenario 'Send friend request from Users show page' do
    reciever = User.create(name: 'Anita', email: 'anita@gmail.com', password: '123456')
    visit root_path
    fill_in 'user_email', with: sender.email
    fill_in 'user_password', with: sender.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')

    click_on 'All users'
    sleep(3)
    expect(page).to have_content("Name: #{reciever.name}")

    first('.profile-link').click # Click on the first 'See Profile' link
    sleep(3)
    expect(page).to have_content("Name: #{reciever.name}")
    expect(page).to have_button('Add friend')

    click_on 'Add friend'
    sleep(3)
    expect(page).to have_content('Friend request was successfully sent.')
  end

  scenario 'Accept friendship' do
    sender.friendships.build(reciever_id: reciever.id, status: false).save
    visit root_path
    fill_in 'user_email', with: reciever.email
    fill_in 'user_password', with: reciever.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')

    click_on 'Friend Requests'
    sleep(3)
    expect(page).to have_content("Name: #{sender.name}")
    expect(page).to have_button('Accept')
    expect(page).to have_button('Decline')

    click_on 'Accept'
    sleep(3)
    expect(page).to have_content('Friend request was successfully confirmed')
    expect(page).to have_content("Name: #{reciever.name}")
  end

  scenario 'Decline friendship' do
    sender.friendships.build(reciever_id: reciever.id, status: false).save
    visit root_path
    fill_in 'user_email', with: reciever.email
    fill_in 'user_password', with: reciever.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')

    click_on 'Friend Requests'
    sleep(3)
    expect(page).to have_content("Name: #{sender.name}")
    expect(page).to have_button('Accept')
    expect(page).to have_button('Decline')

    click_on 'Decline'
    sleep(3)
    expect(page).to have_content('Friend request declined, we won\'t inform the sender')
    expect(page).to have_content("Name: #{reciever.name}")
  end

  scenario 'See posts from the user and his or her friends in the Timeline' do
    reciever.posts.build(content: 'Hello Eugenia').save
    sender.posts.build(content: 'Hello Anita').save
    sender.friendships.build(reciever_id: reciever.id, status: true).save

    visit root_path
    fill_in 'user_email', with: reciever.email
    fill_in 'user_password', with: reciever.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(sender.name)
    expect(page).to have_content('Hello Anita')
    expect(page).to have_content(reciever.name)
    expect(page).to have_content('Hello Eugenia')

    click_on 'Timeline'
    sleep(3)
    expect(page).to have_content(sender.name)
    expect(page).to have_content('Hello Anita')
    expect(page).to have_content(reciever.name)
    expect(page).to have_content('Hello Eugenia')
  end
end
