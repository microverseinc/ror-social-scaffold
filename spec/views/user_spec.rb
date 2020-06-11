require 'rails_helper'

RSpec.describe 'Main Flow', type: :system do
  describe 'User Actions of Platform' do
    it 'Demonstrate Actions: Create Post | Add Friend | Accept Friend' do
      visit('/')
      sleep 1

      # Register
      page.find_by_id('sign-up-link').click
      sleep 1

      # Fill the fields
      fill_in('user[name]', with: 'Crunchy Bacon')
      fill_in('user[email]', with: 'crunchy@bacon.com')
      fill_in('user[password]', with: '123123')
      fill_in('user[password_confirmation]', with: '123123')
      sleep 1
      click_button 'Sign up'
      sleep 1

      fill_in('post[content]', with: 'This test worked')
      click_button 'Save'
      sleep 1
      click_link 'Sign out'

      visit('/')
      sleep 1

      # Register
      page.find_by_id('sign-up-link').click
      sleep 1

      # Fill the fields
      fill_in('user[name]', with: 'Salty Bacon')
      fill_in('user[email]', with: 'salty@bacon.com')
      fill_in('user[password]', with: '123123')
      fill_in('user[password_confirmation]', with: '123123')
      sleep 1
      click_button 'Sign up'

      sleep 1
      click_link 'All users'
      sleep 1
      click_button 'Add Friend'
      sleep 1
      click_link 'Sign out'

      sleep 1
      fill_in('user[email]', with: 'crunchy@bacon.com')
      fill_in('user[password]', with: '123123')
      click_button 'Log in'
      sleep 1
      click_link 'Friends'
      sleep 1
      click_button 'Confirm'
      sleep 3
    end
  end
end
