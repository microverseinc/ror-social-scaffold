require 'rails_helper'

RSpec.feature "SendingRequests", type: :feature do

  let (:user1) { User.create(name: "user1", email: "user1@email.com", password: 'foobar', password_confirmation: 'foobar') }
  let (:user2) { User.create(name: "user2", email: "user2@email.com", password: 'foobar', password_confirmation: 'foobar') }
  
  scenario 'User sends friend request' do
    user2
    log_in(user1)
    expect(page).to have_content('Signed in successfully')

    click_link('All users')
    expect(page).to have_content('user2')
    expect(page).to have_selector(:link_or_button, 'Send Request')
    click_button('Send Request')
    expect(page).not_to have_selector(:link_or_button, 'Send Request')
    click_link('Sign out')

    log_in(user2)
    expect(page).to have_content('Signed in successfully')

    click_link('Friends')
    expect(page).to have_content('user1')
    expect(page).to have_selector(:link_or_button, 'Accept')
    expect(page).to have_selector(:link_or_button, 'Decline')
  end

  scenario 'User can accept or decline friend request' do
  end

  def log_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
