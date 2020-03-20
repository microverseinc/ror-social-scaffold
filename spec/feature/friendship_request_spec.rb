require 'rails_helper'

RSpec.describe 'Process to create a friendship request', type: :feature, js: true do
  feature 'Friendship request' do
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
    end

    scenario 'send friedship request from index view' do
      visit users_path
      sleep(1)
      find('input[value*="Invite to friendship"]').click
      sleep(1)
      expect(page).to have_content 'Cancel Request'
    end

    scenario 'send friedship request from show view' do
      visit user_path(1)
      sleep(1)
      find('input[value*="Invite to friendship"]').click
      sleep(1)
      expect(page).to have_content 'Cancel Request'
    end
  end
end
