require 'rails_helper'
RSpec.describe 'Testing Friendship', type: :feature do
  before(:each) do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass',
                password_confirmation: 'secretpass')
    User.create(name: 'Eze Promise', email: 'e.email@example.com', password: 'password',
                password_confirmation: 'password')
    visit new_user_session_path
    fill_in 'user_email', with: 'e.email@example.com'
    fill_in 'user_password', with: 'password'
    find("input[type='submit']").click

    visit users_path
  end

  it 'Should Add friend from any of the users listed' do
    click_link('Add friend', match: :first)
    expect(page).to have_content('You have sent a friendship request!')
    expect(page).to have_content('Pending Request')
    click_on 'Sign out'
  end
end
