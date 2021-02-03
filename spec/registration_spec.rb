require 'rails_helper'

RSpec.feature 'Form for Sign Up', type: :feature do
  context 'can enter name' do
    scenario 'should be able to enter a name' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Name', with: 'example'
      end
      click_button 'Sign up'
      expect(page).to have_content 'Sign up'
    end
  end
end

RSpec.feature 'Form for Sign Up', type: :feature do
  context 'can enter a password' do
    scenario 'should be able to enter a  password' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Password', with: '123456'
      end
      click_button 'Sign up'
      expect(page).to have_content '6 characters minimum'
    end
  end
end

RSpec.feature 'Form for Sign Up', type: :feature do
  context 'can enter an email' do
    scenario 'should be able to enter an  email' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Email', with: 'em@example.com'
      end
      click_button 'Sign up'
      expect(page).to have_content 'All users'
    end
  end
end