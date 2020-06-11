require 'rails_helper'

RSpec.describe 'Main Flow', type: :system do
  describe 'First User of Platform' do
    it 'Creates Account and create a post' do
      visit('/')
      sleep 1

      # Register
      page.find_by_id('sign-up-link').click
      sleep 2

      # Fill the fields
      fill_in('user[name]', with:'Crunchy Bacon')
      fill_in('user[email]', with:'crunchy@bacon.com')
      fill_in('user[password]', with:'123123')
      fill_in('user[password_confirmation]', with:'123123')
      sleep 3
      click_button 'Sign up'
      sleep 3
    end
  end
end