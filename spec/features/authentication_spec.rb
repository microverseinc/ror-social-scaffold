require 'rails_helper'
require 'spec_helper'

feature 'the sigup process' do
  before(:example) do
    visit '/users/sign_up'
  end

  scenario 'has a new user page' do
    expect(page).to have_content 'Password confirmation'
  end
end

feature 'signing up a user' do
  before(:example) do
    visit '/users/sign_up'
    fill_in 'user_name', with: 'testing'
    fill_in 'user_email', with: 'test@gmail.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'Sign up'
  end

  scenario 'redirects to all users index page after signup' do
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

feature 'signing in as a non-existant user' do
  before(:example) do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'test@gmail.com'
    fill_in 'user_password', with: '12345678'
    click_on 'Log in'
  end

  scenario 'does not re-direct to user page' do
    expect(page).not_to have_content 'Signed in successfully.'
  end

  scenario 'gives error of user not existing' do
    expect(page).to have_content 'Invalid Email or password.'
  end
end

feature 'signing in as an existing user' do
  before(:example) do
    FactoryBot.create(:user)
    visit '/users/sign_in'
    fill_in 'user_email', with: 'apple@gmail.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
  end

  scenario 'redirects to user page after signup' do
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Does not give error of user not existing' do
    expect(page).not_to have_content 'Invalid Email or password.'
  end
end
