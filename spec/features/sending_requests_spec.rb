require 'rails_helper'

RSpec.feature 'SendingRequests', type: :feature do
  let(:user1) do
    User.create(name: 'user1',
                email: 'user1@email.com',
                password: 'foobar',
                password_confirmation: 'foobar')
  end
  let(:user2) do
    User.create(name: 'user2',
                email: 'user2@email.com',
                password: 'foobar',
                password_confirmation: 'foobar')
  end

  scenario 'User sends friend request' do
    user2
    log_in(user1)
    send_request_w_sign_out
    log_in(user2)
    click_link('Friend Requests')
    expect(page).to have_content('user1')
    expect(page).to have_selector(:link_or_button, 'Accept')
    expect(page).to have_selector(:link_or_button, 'Decline')
  end

  def send_request_w_sign_out
    click_link('All users')
    expect(page).to have_content('user2')
    click_button('Send Request')
    expect(page).not_to have_selector(:link_or_button, 'Send Request')
    click_link('Sign out')
  end

  def log_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
