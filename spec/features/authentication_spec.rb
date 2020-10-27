require 'rails_helper'

feature 'user authenticaiton features', type: :feature do
  feature 'signing up a user' do
    scenario 'failing with invalid params' do
      visit '/users/sign_up'
      fill_in 'user_name', with: 'Abdulllah Numan'
      click_on 'Sign up'

      expect(current_path).to eq('/users')
      expect(page).to have_content("can't be blank")
    end
  end
  
  scenario 'successful with valid params' do
    create_user

    expect(current_path).to eq('/')
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  feature 'signing in a user' do
    scenario 'failing with invalid params' do
      create_user
      click_on 'Sign out'
      visit '/users/sign_in'
      fill_in 'user_email', with: 'anewman15@hotmail.com'
      click_on 'Log in'

      expect(current_path).to eq('/users/sign_in')
      expect(page).to have_content("Invalid Email or password.")
    end

    scenario 'successful with valid params' do
      create_user
      click_on 'Sign out'
      fill_in 'user_email', with: 'anewman15@hotmail.com'
      fill_in 'user_password', with: '12345678'
      click_on 'Log in'

      expect(current_path).to eq('/')
      expect(page).to have_content('Signed in successfully.')
    end
  end

  def create_user
    visit '/users/sign_up'
    fill_in 'user_name', with: 'Abdullah Numan'
    fill_in 'user_email', with: 'anewman15@hotmail.com'
    fill_in 'user_password', with: '12345678'
    fill_in 'user_password_confirmation', with: '12345678'
    click_on 'Sign up'
  end
end