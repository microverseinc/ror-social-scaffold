require 'rails_helper'

# rspec spec/views/user_spec.rb
RSpec.describe 'Main flow', type: :system do
  describe 'New user' do
    it 'Make account, login, create post and logout' do
      # Singn up First User
      visit('/users/sign_up')
      sleep 1

      # Sign up
      fill_in('user[name]', with: 'Test')
      sleep 1
      fill_in('user[email]', with: 'test@mail.com')
      sleep 1
      fill_in('user[password]', with: 'password')
      sleep 1
      fill_in('user[password_confirmation]', with: 'password')
      sleep 1
      click_button('Sign up')

      # # Sign In
      # fill_in('user_id', with: '1')
      # sleep 1
      # click_button('Submit')
      # sleep 1

      # Create New post
      fill_in('post[content]', with: 'First Post')
      sleep 1
      click_button('Save')
      sleep 1

      # Go to user dashboard
      # visit('/users/1')
      # sleep 1

      # Farewell my friends
      click_link('Sign out')
      sleep 1

      # Sign up Second User
      visit('/users/sign_up')
      sleep 1

      # Sign up
      fill_in('user[name]', with: 'Test2')
      sleep 1
      fill_in('user[email]', with: 'test2@mail.com')
      sleep 1
      fill_in('user[password]', with: 'password')
      sleep 1
      fill_in('user[password_confirmation]', with: 'password')
      sleep 1
      click_button('Sign up')

      visit('/posts/1')
      sleep
    end
  end
end
