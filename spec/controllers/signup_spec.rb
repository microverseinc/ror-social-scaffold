require 'rails_helper'

feature 'Sign up functionality', type: :feature do
  feature 'Create a new user' do
    before(:each) do
      visit '/users/sign_up'
    end

    scenario 'when you signup with empty fields' do
      fill_in 'Name', with: 'foo'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      expect(current_path).to eq('/users')
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'when you signup with with valid params' do
      fill_in 'Name', with: 'bar'
      fill_in 'Email', with: 'bar@mail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully')
      expect(current_path).to eq('/')
    end
  end
end
