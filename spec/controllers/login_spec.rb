require 'rails_helper'

feature 'Log in feature page', type: :feature do
  feature 'Login an existing user' do
    before(:each) do
      User.create(name: 'Foo', email: 'foo@mail.com', password: 'password', password_confirmation: 'password')
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'foo@mail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
    end

    scenario 'when you login with valid params' do
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Sign out')
    end
  end
end
