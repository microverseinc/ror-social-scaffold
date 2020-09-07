require 'rails_helper'

RSpec.describe 'Friendship Management Features', type: :feature do
  let(:mary) do
    {
      name: 'Mary', email: 'm@gmail.com', password: 'password', password_confirmation: 'password'
    }
  end
  let(:jane) { { name: 'Jane', email: 'j@gmail.com', password: 'password', password_confirmation: 'password' } }

  before :each do
    # register_user mary
    visit new_user_registration_path
    fill_in 'Name', with: mary[:name]
    fill_in 'Email', with: mary[:email]
    fill_in 'Password', with: mary[:password]
    fill_in 'Password confirmation', with: mary[:password_confirmation]
    click_button 'Sign up'
    click_on 'Sign out'
    # register_user jane
    visit new_user_registration_path
    fill_in 'Name', with: jane[:name]
    fill_in 'Email', with: jane[:email]
    fill_in 'Password', with: jane[:password]
    fill_in 'Password confirmation', with: jane[:password_confirmation]
    click_button 'Sign up'
  end
  scenario 'user can send a friendship request to another user' do
    fill_in :post_content, with: 'Hello users, I am Jane.'
    click_button 'Save'
    click_on 'All users'
    click_button 'Add Friend'

    expect(page).to have_content("A friendship request was sent and is awaiting confirmation\nName: #{mary[:name]}\n")
  end

  scenario 'a user with a pending friendship request can accept it on the all users\' list' do
    # Jane creates a post and sends a friend request to Mary
    jane_post = 'Hello users, I am Jane.'
    fill_in :post_content, with: jane_post
    click_button 'Save'
    click_on 'All users'
    click_button 'Add Friend'
    click_on 'Sign out'

    # Sign in as Mary
    visit new_user_session_path
    fill_in 'Email', with: mary[:email]
    fill_in 'Password', with: mary[:password]
    click_button 'Log in'

    # Mary accepts Jane's friend request
    click_on 'All users'
    click_button 'Accept'

    expect(page).to have_content("You are now friends with #{jane[:name]}")
    click_on 'Timeline'
    expect(page).to have_content(jane_post)
  end

  scenario 'a user with a pending friendship request can accept it on the sender\'s profile page' do
    # Jane creates a post and sends a friend request to Mary
    jane_post = 'Hello users, I am Jane.'
    fill_in :post_content, with: jane_post
    click_button 'Save'
    click_on 'All users'
    click_button 'Add Friend'
    click_on 'Sign out'

    # Sign in as Mary
    visit new_user_session_path
    fill_in 'Email', with: mary[:email]
    fill_in 'Password', with: mary[:password]
    click_button 'Log in'

    # Mary creates a post and accepts Jane's friend request
    mary_post = 'Hello users, I am Mary.'
    fill_in :post_content, with: mary_post
    click_button 'Save'
    click_on mary[:name]
    expect(page).to have_content('Pending Friend Requests:')
    click_on jane[:name]
    click_button 'Accept'
    expect(page).to have_content("You are now friends with #{jane[:name]}")
    click_on 'Timeline'
    expect(page).to have_content(jane_post)
    click_on 'Sign out'

    # Sign in as Jane
    visit new_user_session_path
    fill_in 'Email', with: jane[:email]
    fill_in 'Password', with: jane[:password]
    click_button 'Log in'
    expect(page).to have_content(mary_post)
  end

  scenario 'a user with a pending friendship request can accept it on their profile page' do
    # Jane creates a post and sends a friend request to Mary
    jane_post = 'Hello users, I am Jane.'
    fill_in :post_content, with: jane_post
    click_button 'Save'
    click_on 'All users'
    click_button 'Add Friend'
    click_on 'Sign out'

    # Sign in as Mary
    visit new_user_session_path
    fill_in 'Email', with: mary[:email]
    fill_in 'Password', with: mary[:password]
    click_button 'Log in'

    # Mary creates a post and accepts Jane's friend request
    mary_post = 'Hello users, I am Mary.'
    fill_in :post_content, with: mary_post
    click_button 'Save'
    click_on mary[:name]
    expect(page).to have_content('Pending Friend Requests:')
    click_button 'Accept'
    expect(page).to have_content("You are now friends with #{jane[:name]}")
    click_on 'Timeline'
    expect(page).to have_content(jane_post)
    click_on 'Sign out'

    # Sign in as Jane
    visit new_user_session_path
    fill_in 'Email', with: jane[:email]
    fill_in 'Password', with: jane[:password]
    click_button 'Log in'
    expect(page).to have_content(mary_post)
  end

  scenario 'a user with a pending friendship request can reject it on the all users\' list' do
    # Jane creates a post and sends a friend request to Mary
    jane_post = 'Hello users, I am Jane.'
    fill_in :post_content, with: jane_post
    click_button 'Save'
    click_on 'All users'
    click_button 'Add Friend'
    click_on 'Sign out'

    # Sign in as Mary
    visit new_user_session_path
    fill_in 'Email', with: mary[:email]
    fill_in 'Password', with: mary[:password]
    click_button 'Log in'

    # Mary accepts Jane's friend request
    click_on 'All users'
    click_button 'Reject'

    expect(page).to have_content("The friendship request from #{jane[:name]} was successfully rejected")
    click_on 'Timeline'
    expect(page).not_to have_content(jane_post)
  end

  scenario 'a user with a pending friendship request can reject it on the user\'s profile page' do
    # Jane creates a post and sends a friend request to Mary
    jane_post = 'Hello users, I am Jane.'
    fill_in :post_content, with: jane_post
    click_button 'Save'
    click_on 'All users'
    click_button 'Add Friend'
    click_on 'Sign out'

    # Sign in as Mary
    visit new_user_session_path
    fill_in 'Email', with: mary[:email]
    fill_in 'Password', with: mary[:password]
    click_button 'Log in'

    # Mary creates a post and accepts Jane's friend request
    mary_post = 'Hello users, I am Mary.'
    fill_in :post_content, with: mary_post
    click_button 'Save'
    click_on mary[:name]
    expect(page).to have_content('Pending Friend Requests:')
    click_on jane[:name]
    click_button 'Reject'
    expect(page).not_to have_content("You are now friends with #{jane[:name]}")
    expect(page).to have_content("The friendship request from #{jane[:name]} was successfully rejected")
    click_on 'Timeline'
    expect(page).not_to have_content(jane_post)
    click_on 'Sign out'

    # Sign in as Jane
    visit new_user_session_path
    fill_in 'Email', with: jane[:email]
    fill_in 'Password', with: jane[:password]
    click_button 'Log in'
    expect(page).not_to have_content(mary_post)
  end

  scenario 'a user with a pending friendship request can reject it on their profile page' do
    # Jane creates a post and sends a friend request to Mary
    jane_post = 'Hello users, I am Jane.'
    fill_in :post_content, with: jane_post
    click_button 'Save'
    click_on 'All users'
    click_button 'Add Friend'
    click_on 'Sign out'

    # Sign in as Mary
    visit new_user_session_path
    fill_in 'Email', with: mary[:email]
    fill_in 'Password', with: mary[:password]
    click_button 'Log in'

    # Mary creates a post and accepts Jane's friend request
    mary_post = 'Hello users, I am Mary.'
    fill_in :post_content, with: mary_post
    click_button 'Save'
    click_on mary[:name]
    expect(page).to have_content('Pending Friend Requests:')
    click_button 'Reject'
    expect(page).not_to have_content("You are now friends with #{jane[:name]}")
    expect(page).to have_content("The friendship request from #{jane[:name]} was successfully rejected")
    click_on 'Timeline'
    expect(page).not_to have_content(jane_post)
    click_on 'Sign out'

    # Sign in as Jane
    visit new_user_session_path
    fill_in 'Email', with: jane[:email]
    fill_in 'Password', with: jane[:password]
    click_button 'Log in'
    expect(page).not_to have_content(mary_post)
  end
end
