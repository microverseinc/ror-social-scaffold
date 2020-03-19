require 'rails_helper'

RSpec.describe 'Process to cancel a friendship request', type: :feature, js: true do
  feature 'Cancel request' do
    before(:each) do
      visit new_user_registration_path
      fill_in 'Name', with: 'remy'
      fill_in 'Email', with: 'remy@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      find('a[href*="/users/sign_ou"]').click

      visit new_user_registration_path
      fill_in 'Name', with: 'ivancito'
      fill_in 'Email', with: 'ivancito@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      find('input[value*="Sign up"]').click

      visit users_path
      find('input[value*="Invite to friendship"]').click
    end

    scenario 'send cancel request from index view' do
      sleep(1)
      find('a[href*="/users/fiendships/1/cancel"]').click
      sleep(1)
      expect(page).to have_text 'You have canceled the friend request'
      sleep(1)
    end

    scenario 'send cancel request from show view' do
      visit user_path(1)
      sleep(1)
      find('a[href*="/users/fiendships/1/cancel"]').click
      sleep(1)
      expect(page).to have_text 'You have canceled the friend request'
      sleep(1)
    end
  end
end
