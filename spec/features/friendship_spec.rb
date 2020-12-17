require 'rails_helper'
RSpec.describe 'Testing Friendship', type: :feature do
  before(:each) do
    User.create(name: 'Alex', email: 'alex@gmail.com', password: '123456',
                password_confirmation: '123456')
    User.create(name: 'Joha', email: 'joha@gmail.com', password: 'password',
                password_confirmation: 'password')
    visit new_user_session_path
    fill_in 'user_email', with: 'alex@gmail.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click

    visit users_path
  end

  it 'Should send the friend request to the user listed' do
    click_link('See Profile', match: :first)
    expect(page).to have_content('Name:')
    click_on 'Sign out'
  end
end
