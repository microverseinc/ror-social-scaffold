require 'rails_helper'

feature 'sign up process' do
  scenario 'has a new user sign up page' do
    visit new_user_registration_path
    expect(page).to have_content 'Sign up'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_registration_path
      fill_in 'Name', with: 'testing_username'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'cake,biscuitsandtea'
      fill_in 'Password confirmation', with: 'cake,biscuitsandtea'
      click_on 'Sign up'
    end

    scenario 'redirects to root path after signup' do
      expect(page).to have_content 'Sign out'
    end
  end
end