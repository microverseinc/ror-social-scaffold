require 'rails_helper'

RSpec.describe 'Some description' do
  # Populate the database
  before :each do
    user = User.create(name: 'User1',
                       email: 'user1@example.com',
                       password: '123456',
                       password_confirmation: '123456')
  end

  describe 'log in process', type: :feature do
    it 'logs in' do
      visit 'users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'user1@example.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
