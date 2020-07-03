require 'rails_helper'

RSpec.feature 'Authentications', type: :feature do
  describe 'the signin process' do
    before :each do
      User.create(name: 'Marios', email: 'b@b.com', password: '000000', password_confirmation: '000000')
      visit 'users/sign_in'
      within('#new_user') do
        fill_in 'user_email', with: 'b@b.com'
        fill_in 'user_password', with: '000000'
      end
      click_button 'commit'
    end

    it 'signs me in' do
      expect(page).to have_content 'Marios'
    end

    it 'signs me out' do
      click_link('Sign out')
      expect(page).to have_content 'Sign in'
    end
  end
end
