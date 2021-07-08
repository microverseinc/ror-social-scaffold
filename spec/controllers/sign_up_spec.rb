require 'rails_helper'

describe 'Controller', type: :system do
  describe 'Signing up new user' do
    before :each do
      visit new_user_registration_path
    end
    it 'should not work without Email' do
      fill_in 'Name', with: 'bla bla black sheep'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      sleep(2)
      expect(page).to have_content("Email can't be blank")
    end

    it 'should not work without password' do
      fill_in 'Name', with: 'Dan'
      fill_in 'Email', with: 'dan@vv.com'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      sleep(2)
      expect(page).to have_content("Password can't be blank")
    end

    it 'signs up with correct details' do
      fill_in 'Name', with: 'Xavier'
      fill_in 'Email', with: 'xvv@vv.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      sleep(2)
      expect(page).to have_content('ALL USERS')
    end
  end
end
