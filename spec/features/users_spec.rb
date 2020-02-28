require 'rails_helper'

RSpec.feature 'User' do
  before(:each) do
    visit_page_and_fill_in_form
  end
  context 'Sign Up' do
    it 'with valid attributes' do
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'with invalid name' do
      fill_in 'Name', with: ''
      click_button 'Sign up'
      expect(page).to have_content("Name can't be blank")
    end

    it 'with invalid email' do
      fill_in 'Email', with: ''
      click_button 'Sign up'
      expect(page).to have_content("Email can't be blank")
    end

    it 'with invalid password' do
      fill_in 'Password', with: ''
      click_button 'Sign up'
      expect(page).to have_content("Password can't be blank")
    end

    it 'with no matching passwords' do
      fill_in 'Password confirmation', with: '123password'
      click_button 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end

RSpec.feature 'User' do
  before(:each) do
    visit_page_and_fill_in_form
  end
  context 'Sign Up' do
    it 'with too short password' do
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_button 'Sign up'
      expect(page).to have_content('Password is too short (minimum is 6 characters)')
    end

    it 'with an email already taken' do
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
      click_link 'Sign out'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      visit new_user_registration_path
      within('form') do
        fill_in 'Name', with: 'john'
        fill_in 'Email', with: 'john@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Email has already been taken')
    end
  end
end

RSpec.feature 'User' do
  before(:each) do
    visit_page_and_fill_in_form
  end

  context 'Log in' do
    before(:each) do
      sign_up_sign_out
    end

    it 'with valid credential' do
      within('form') do
        fill_in 'Email', with: 'john@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end
end

RSpec.feature 'User' do
  before(:each) do
    visit_page_and_fill_in_form
  end

  context 'Log in' do
    before(:each) do
      sign_up_sign_out
    end

    it 'with invalid email or password' do
      within('form') do
        fill_in 'Email', with: 'johngmail.com'
        fill_in 'Password', with: 'passwor'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end

def visit_page_and_fill_in_form
  visit new_user_registration_path
  within('form') do
    fill_in 'Name', with: 'john'
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
  end
end

def sign_up_sign_out
  click_button 'Sign up'
  expect(page).to have_content('Welcome! You have signed up successfully.')
  click_link 'Sign out'
end
