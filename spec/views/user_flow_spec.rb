=begin
require 'rails_helper'

# rspec spec/views/user_spec.rb
RSpec.describe 'Main flow', type: :system do
  describe 'New user' do
    it 'Make account, login, create post and logout' do
      # Access Home Page
      visit('/')
      sleep 1

      # Go to Sign Up page
      click_link('Sign Up')
      sleep 1

      # Sing up
      fill_in('user[name]', with: 'Test')
      sleep 1
      fill_in('user[email]', with: 'test@mail.com')
      sleep 1
      fill_in('user[password]', with: 'password')
      sleep 1
      fill_in('user[password]', with: 'password')
      sleep 1
      click_button('SIGN UP')

      # Go to Sign In page
      visit('/signin')
      sleep 1

      # Sign In
      fill_in('User ID', with: '1')
      sleep 1
      click_button('Submit')
      sleep 1

      # Go to Create New Event page
      visit('/events/new')
      sleep 1

      # Create New Event
      fill_in('event[title]', with: 'Freds Big Party')
      sleep 1
      fill_in('event[event_date]', with: Time.now + 1.month)
      sleep 1
      click_button('Create Event')
      sleep 1

      # Go to Create New Event page
      visit('/users/1')
      sleep 1

      # Farewell my friends
      click_button('Logout')
      sleep 1
    end
  end
end
=end