require 'rails_helper'

feature 'Sign up and login tests', type: :feature do
  feature 'sign up a new user' do
    before(:each) do
      visit new_user_registration_path
    end

    scenario 'with invalid inputs' do
      user = FactoryBot.build(:user)
      within('form') do
        fill_in 'user_name', with: user.name
      end
      click_on 'Sign up'
      expect(page).to have_content('errors prohibited this user from being saved:')
    end

    scenario 'with existing user' do
      user = FactoryBot.create(:user)
      within('form') do
        fill_in 'user_name', with: user.name
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password
      end
      click_on 'Sign up'
      expect(page).to have_content('Email has already been taken')
    end

    scenario 'with valid inputs' do
      user = FactoryBot.build(:user)
      within('form') do
        fill_in 'user_name', with: user.name
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password
      end
      click_on 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  feature 'log in a user' do
    before(:each) do
      visit new_user_session_path
    end

    scenario 'with invalid inputs' do
      user = FactoryBot.create(:user)
      within('form') do
        fill_in 'user_email', with: user.email
      end
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    scenario 'with valid inputs' do
      user = FactoryBot.create(:user)
      within('form') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
      end
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end
end
