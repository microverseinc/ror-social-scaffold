require 'rails_helper'

RSpec.describe 'Process to accept a friendship request', type: :feature, js: true do
  feature 'Accept request' do
    before(:each) do
      visit new_user_registration_path
      fill_in 'Name', with: 'remy'
      fill_in 'Email', with: 'remy@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      find('input[value*="Sign up"]').click
      find('a[href*="/users/sign_ou"]').click

      visit new_user_registration_path
      fill_in 'Name', with: 'ivancito'
      fill_in 'Email', with: 'ivancito@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      find('input[value*="Sign up"]').click

      visit users_path
      find('input[value*="Invite to friendship"]').click
      find('a[href*="/users/sign_ou"]').click

      visit new_user_session_path
      fill_in 'Email', with: 'remy@gmail.com'
      fill_in 'Password', with: 'password'
      find('input[value*="Log in"]').click

      visit users_path
      find('a[href*="/users/fiendships/2/acept"]').click
    end

    scenario 'send friedship request from index view' do
      sleep(1)
      find('a[href*="/users/fiendships/2/unfriend"]').click
      sleep(1)
      expect(page).to have_text 'You have canceled ivancito request to be your friend'
      sleep(1)
    end

    scenario 'send friedship request from show view' do
      visit user_path(2)
      sleep(1)
      find('a[href*="/users/fiendships/2/unfriend"]').click
      sleep(1)
      expect(page).to have_text 'You have canceled ivancito request to be your friend'
      sleep(1)
    end
  end
end
