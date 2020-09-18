require 'rails_helper'

RSpec.describe 'Authentification', type: :system do
  it 'sign up user' do
    visit new_user_registration_path
    fill_in 'user[name]', with: 'Yahir'
    fill_in 'user[email]', with: 'yahir.cardona@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'Sign in' do
    @user = User.new(name: 'Yahir', email: 'yahir@example.com', password: 'password')
    @user.save
    visit new_user_session_path
    fill_in 'user[email]', with: 'yahir@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
end
