require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  describe 'logging in the user' do
    before(:each) do
      User.create(name: 'User', email: 'user@example.com', password: '123456', password_confirmation: '123456')
      visit 'users/sign_in'
      within '#new_user' do
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '123456'
      end
      click_button 'Log in'
    end

    it 'should log in the user' do
      expect(page).to have_content('user')
    end

    it 'logs out the user' do
      click_link 'Sign out'
      expect(page).to have_content 'Sign in'
    end
  end
end
