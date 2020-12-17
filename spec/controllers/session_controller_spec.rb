require 'rails_helper'

RSpec.describe 'Session pages', type: :feature do
  let(:user) do
    User.create(name: 'mytest1', email: 'testing@gmail.com',
                password: 'testing', password_confirmation: 'testing')
  end
  scenario 'login' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'signup page' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'mytest1'
    fill_in 'user_email', with: 'mytest@gmain.com'
    fill_in 'user_password', with: 'mytest'
    fill_in 'user_password_confirmation', with: 'mytest'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully')
  end
end
