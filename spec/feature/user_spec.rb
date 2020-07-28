require_relative '../rails_helper'

RSpec.describe 'Webpage workflow', type: :system do
  describe 'Navigate the webpage' do
    it 'creates a new user and add friendship relationship' do
      User.create(name: 'Legolas', email: 'legolas@hotmail.com', password: 'thelord')
      visit new_user_registration_path
      fill_in 'Name', with: 'Frodo'
      fill_in 'Email', with: 'frodo@hotmail.com'
      fill_in 'Password', with: 'thelord'
      fill_in 'Password confirmation', with: 'thelord'
      click_on 'Sign up'
      sleep(3)
      expect(page).to have_content('Welcome! You have signed up successfully.')
      click_on 'All users'
      sleep(3)
      click_on 'Add as a friend'
      sleep(3)
      expect(page).to have_content('Friend request sent.')
      click_on 'Sign Out'
      sleep(3)
      fill_in 'Email', with: 'legolas@hotmail.com'
      fill_in 'Password', with: 'thelord'
      click_on 'Log in'
      sleep(3)
      click_on 'All users'
      click_on 'Accept friend request'
      sleep(3)
      expect(page).to have_content('Friend request accepted.')
    end
  end
end
