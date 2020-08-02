require 'rails_helper'

RSpec.describe 'Log In Feature', type: :feature do
  let(:user) { User.new(name: 'newlog', email: 'user@site.com', password: 'some123pass') }

  scenario 'empty email field cant log in' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: nil
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'Already created user account can log in' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'form with empty password field will not be logged in' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: nil
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
