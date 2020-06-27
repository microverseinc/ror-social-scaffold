require 'rails_helper'

# rspec spec/views/user_spec.rb
RSpec.describe 'Main flow', type: :system do
  describe 'New user' do
    it 'Logs in, creates post and logout' do
      visit('/users/sign_up')
      # Sign up User1
      fill_in('user[name]', with: 'Test')
      fill_in('user[email]', with: 'test@mail.com')
      fill_in('user[password]', with: 'password')
      fill_in('user[password_confirmation]', with: 'password')
      click_button('Sign up')

      # Create New post
      fill_in('post[content]', with: 'First Post')
      click_button('Save')
      click_link('Sign out')

      # Sign up User2
      visit('/users/sign_up')
      fill_in('user[name]', with: 'Test2')
      fill_in('user[email]', with: 'test2@mail.com')
      fill_in('user[password]', with: 'password')
      fill_in('user[password_confirmation]', with: 'password')
      click_button('Sign up')

      # Send Friend Request
      click_link 'All users'
      click_button 'Send Friend Request'
      click_link 'Sign out'
    end
  end
end
