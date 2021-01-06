require 'rails_helper'

RSpec.describe 'User features', type: :request do
  scenario 'fail to login' do
    visit root_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'logs in' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'tadeu'
    fill_in 'user_email', with: 'tadeu@tadeu.com'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')

    visit root_path
    click_link 'Sign out'

    visit new_user_session_path
    fill_in 'user_email', with: 'tadeu@tadeu.com'
    fill_in 'user_password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'logs out' do
    visit destroy_user_session_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
