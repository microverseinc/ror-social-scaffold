require 'rails_helper'

RSpec.describe 'Authentications', type: :feature do
  before :each do
    User.create(name: 'Alex', email: 'alex@mail.com', password: '123456')
  end

  it 'signs up' do
    visit user_registration_path
    click_on 'Sign up'
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Name')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password (6 characters minimum)')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_content('Log in')
    fill_in 'user[name]', with: 'TestUser'
    fill_in 'user[email]', with: 'testuser@mail.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'signs in' do
    visit user_session_path
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Forgot your password?')
    fill_in 'user[email]', with: 'alex@mail.com'
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  it 'signs out' do
    visit user_session_path
    fill_in 'user[email]', with: 'alex@mail.com'
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    click_on 'Sign out'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
